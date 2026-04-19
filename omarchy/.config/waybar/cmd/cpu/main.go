// Put this on your waybar config.jsonc
// then add "custom/cpu" to any of the modules (modules-left, modules-right or modules-center)
//
//	"custom/cpu": {
//	  "exec": "~/.config/waybar/cpu",
//	  "format": "󰍛",
//	  "interval": 3,
//	  "return-type": "json"
//	},

// BUILD: go build -o ~/.config/waybar ./cmd/cpu

package main

import (
	"encoding/json"
	"fmt"
	"os"
	"strconv"
	"strings"
	"time"
)

type WaybarOutput struct {
	Text    string `json:"text"`
	Tooltip string `json:"tooltip"`
	Class   string `json:"class"`
}

// ── CPU ──────────────────────────────────────────────────────────────────────

func getCPUUsage() (float64, error) {
	readStat := func() (idle, total uint64, err error) {
		data, err := os.ReadFile("/proc/stat")
		if err != nil {
			return 0, 0, err
		}
		for _, line := range strings.Split(string(data), "\n") {
			if strings.HasPrefix(line, "cpu ") {
				fields := strings.Fields(line)
				var vals []uint64
				for _, f := range fields[1:] {
					v, _ := strconv.ParseUint(f, 10, 64)
					vals = append(vals, v)
				}
				if len(vals) >= 5 {
					idle = vals[3] + vals[4]
					for _, v := range vals {
						total += v
					}
				}
				return
			}
		}
		return 0, 0, fmt.Errorf("cpu line not found")
	}

	idle1, total1, err := readStat()
	if err != nil {
		return 0, err
	}
	time.Sleep(200 * time.Millisecond)
	idle2, total2, err := readStat()
	if err != nil {
		return 0, err
	}

	deltaTotal := float64(total2 - total1)
	deltaIdle := float64(idle2 - idle1)
	if deltaTotal == 0 {
		return 0, nil
	}
	return (1.0 - deltaIdle/deltaTotal) * 100.0, nil
}

func getCPUTemp() (float64, error) {
	entries, err := os.ReadDir("/sys/class/hwmon")
	if err != nil {
		return 0, err
	}
	for _, e := range entries {
		nameBytes, err := os.ReadFile("/sys/class/hwmon/" + e.Name() + "/name")
		if err != nil {
			continue
		}
		if strings.TrimSpace(string(nameBytes)) == "k10temp" {
			data, err := os.ReadFile("/sys/class/hwmon/" + e.Name() + "/temp1_input")
			if err != nil {
				continue
			}
			val, err := strconv.ParseFloat(strings.TrimSpace(string(data)), 64)
			if err != nil {
				continue
			}
			return val / 1000.0, nil
		}
	}
	return 0, fmt.Errorf("k10temp not found")
}

// ── GPU ──────────────────────────────────────────────────────────────────────

type GPUInfo struct {
	Temp      float64
	Usage     float64
	VRAMUsed  uint64
	VRAMTotal uint64
	FanRPM    uint64
	FanMax    uint64
}

func readUint(path string) (uint64, error) {
	data, err := os.ReadFile(path)
	if err != nil {
		return 0, err
	}
	return strconv.ParseUint(strings.TrimSpace(string(data)), 10, 64)
}

func getGPUInfo() (*GPUInfo, error) {
	info := &GPUInfo{}

	entries, err := os.ReadDir("/sys/class/hwmon")
	if err != nil {
		return nil, err
	}
	for _, e := range entries {
		nameBytes, err := os.ReadFile("/sys/class/hwmon/" + e.Name() + "/name")
		if err != nil {
			continue
		}
		if strings.TrimSpace(string(nameBytes)) == "amdgpu" {
			base := "/sys/class/hwmon/" + e.Name()
			if data, err := os.ReadFile(base + "/temp1_input"); err == nil {
				if val, err := strconv.ParseFloat(strings.TrimSpace(string(data)), 64); err == nil {
					info.Temp = val / 1000.0
				}
			}
			if v, err := readUint(base + "/fan1_input"); err == nil {
				info.FanRPM = v
			}
			if v, err := readUint(base + "/fan1_max"); err == nil {
				info.FanMax = v
			}
			break
		}
	}

	for _, card := range []string{"card0", "card1", "card2"} {
		base := "/sys/class/drm/" + card + "/device"
		if _, err := os.Stat(base + "/gpu_busy_percent"); err != nil {
			continue
		}
		if v, err := readUint(base + "/gpu_busy_percent"); err == nil {
			info.Usage = float64(v)
		}
		if v, err := readUint(base + "/mem_info_vram_used"); err == nil {
			info.VRAMUsed = v
		}
		if v, err := readUint(base + "/mem_info_vram_total"); err == nil {
			info.VRAMTotal = v
		}
		break
	}

	return info, nil
}

// ── Helpers ──────────────────────────────────────────────────────────────────

func mbStr(bytes uint64) string {
	return fmt.Sprintf("%.0f MB", float64(bytes)/1024/1024)
}

func cssClass(cpuPct, cpuTemp float64) string {
	if cpuTemp > 85 || cpuPct > 90 {
		return "critical"
	}
	if cpuTemp > 70 || cpuPct > 70 {
		return "warning"
	}
	return "normal"
}

// ── Main ─────────────────────────────────────────────────────────────────────

func main() {
	cpuUsage, _ := getCPUUsage()
	cpuTemp, cpuTempErr := getCPUTemp()
	gpu, gpuErr := getGPUInfo()

	var text string
	if cpuTempErr == nil && gpuErr == nil {
		text = fmt.Sprintf(" %.0f%%  %.0f°C   %.0f%%  %.0f°C", cpuUsage, cpuTemp, gpu.Usage, gpu.Temp)
	} else if cpuTempErr == nil {
		text = fmt.Sprintf(" %.0f%%  %.0f°C", cpuUsage, cpuTemp)
	} else {
		text = fmt.Sprintf(" %.0f%%", cpuUsage)
	}

	var sb strings.Builder

	fmt.Fprintf(&sb, "<b>󰻠 CPU</b>\n")
	fmt.Fprintf(&sb, "  Usage:       %.1f%%\n", cpuUsage)
	if cpuTempErr == nil {
		fmt.Fprintf(&sb, "  Temperature: %.1f°C\n", cpuTemp)
	}

	if gpuErr == nil {
		fmt.Fprintf(&sb, "\n<b>󰍛 GPU</b>\n")
		fmt.Fprintf(&sb, "  Usage:       %.0f%%\n", gpu.Usage)
		fmt.Fprintf(&sb, "  Temperature: %.1f°C\n", gpu.Temp)
		if gpu.VRAMTotal > 0 {
			pct := float64(gpu.VRAMUsed) / float64(gpu.VRAMTotal) * 100
			fmt.Fprintf(&sb, "  VRAM:        %s / %s (%.0f%%)\n", mbStr(gpu.VRAMUsed), mbStr(gpu.VRAMTotal), pct)
		}
		if gpu.FanMax > 0 {
			fanPct := float64(gpu.FanRPM) / float64(gpu.FanMax) * 100
			fmt.Fprintf(&sb, "  Fan:         %d RPM (%.0f%%)\n", gpu.FanRPM, fanPct)
		} else if gpu.FanRPM > 0 {
			fmt.Fprintf(&sb, "  Fan:         %d RPM\n", gpu.FanRPM)
		}
	}

	class := "normal"
	if cpuTempErr == nil {
		class = cssClass(cpuUsage, cpuTemp)
	} else if cpuUsage > 90 {
		class = "critical"
	} else if cpuUsage > 70 {
		class = "warning"
	}

	out := WaybarOutput{
		Text:    text,
		Tooltip: strings.TrimRight(sb.String(), "\n"),
		Class:   class,
	}

	encoded, _ := json.Marshal(out)
	fmt.Println(string(encoded))
}
