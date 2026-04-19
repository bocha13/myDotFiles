// WARN: DON'T FORGET TO SET OWM_API_KEY ON YOUR ENV!!!
// WARN: you need to add the variable to the /etc/environment file
// WARN: because waybar loads before bashrc is called
//
//	Put this on your waybar config.jsonc
//	then add "custom/weather" to any of the modules (modules-left, modules-right or modules-center)
//
//	 "custom/weather": {
//	   "exec": "~/.config/waybar/weather",
//	   "interval": 600, // refresh every 10 min
//	   "return-type": "json",
//	   "id": "custom-weather"
//	 },

// BUILD: go build -o ~/.config/waybar ./cmd/weather
package main

import (
	"encoding/json"
	"fmt"
	"math"
	"net/http"
	"os"
	"strings"
	"time"
	"unicode"
)

type WaybarOutput struct {
	Text    string `json:"text"`
	Tooltip string `json:"tooltip"`
	Class   string `json:"class"`
}

const (
	city  = "Santa%20Fe,AR"
	units = "metric"
)

type CurrentWeather struct {
	Main struct {
		Temp      float64 `json:"temp"`
		FeelsLike float64 `json:"feels_like"`
		Humidity  int     `json:"humidity"`
	} `json:"main"`
	Weather []struct {
		ID          int    `json:"id"`
		Description string `json:"description"`
		Icon        string `json:"icon"`
	} `json:"weather"`
	Wind struct {
		Speed float64 `json:"speed"`
	} `json:"wind"`
	Name string `json:"name"`
}

type Forecast struct {
	List []struct {
		Dt   int64 `json:"dt"`
		Main struct {
			TempMin float64 `json:"temp_min"`
			TempMax float64 `json:"temp_max"`
		} `json:"main"`
		Weather []struct {
			ID          int    `json:"id"`
			Description string `json:"description"`
		} `json:"weather"`
	} `json:"list"`
}

func getDayNight() string {
	hour := time.Now().Hour()
	if hour >= 20 || hour < 7 {
		return "n"
	}
	return "d"
}

func getIcon(id int, iconCode string) string {
	isNight := strings.HasSuffix(iconCode, "n")
	switch {
	case id >= 200 && id < 300:
		return "⛈️"
	case id >= 300 && id < 400:
		return "🌧️"
	case id >= 500 && id < 600:
		return "🌧️"
	case id >= 600 && id < 700:
		return "❄️"
	case id >= 700 && id < 800:
		return "🌫️"
	case id == 800:
		if isNight {
			return "🌙"
		}
		return "☀️"
	case id == 801:
		if isNight {
			return "🌙☁️"
		}
		return "🌤️"
	case id == 802:
		if isNight {
			return "🌙☁️"
		}
		return "⛅"
	case id >= 803:
		return "☁️"
	default:
		return "🌡️"
	}
}

func titleCase(s string) string {
	words := strings.Fields(s)
	for i, w := range words {
		runes := []rune(w)
		runes[0] = unicode.ToUpper(runes[0])
		words[i] = string(runes)
	}
	return strings.Join(words, " ")
}

func main() {
	apiKey := os.Getenv("OWM_API_KEY")
	if apiKey == "" {
		outputError("OWM_API_KEY not set")
		return
	}

	client := &http.Client{Timeout: 10 * time.Second}

	currentURL := fmt.Sprintf("https://api.openweathermap.org/data/2.5/weather?q=%s&units=%s&appid=%s", city, units, apiKey)
	var current *CurrentWeather
	var err error
	for attempt, delays := 0, []time.Duration{3 * time.Second, 7 * time.Second, 15 * time.Second}; attempt <= len(delays); attempt++ {
		current, err = fetchJSON[CurrentWeather](client, currentURL)
		if err == nil {
			break
		}
		if attempt < len(delays) {
			time.Sleep(delays[attempt])
		}
	}
	if err != nil {
		outputError(err.Error())
		return
	}

	forecastURL := fmt.Sprintf("https://api.openweathermap.org/data/2.5/forecast?q=%s&units=%s&appid=%s", city, units, apiKey)
	forecast, err := fetchJSON[Forecast](client, forecastURL)
	if err != nil {
		outputError(err.Error())
		return
	}

	// Current weather
	icon := "🌡️"
	if len(current.Weather) > 0 {
		icon = getIcon(current.Weather[0].ID, current.Weather[0].Icon)
	}
	text := fmt.Sprintf("%s %.0f°C", icon, current.Main.Temp)

	// Tooltip
	var tooltip strings.Builder
	tooltip.WriteString(fmt.Sprintf("<b>%s</b>\n", current.Name))
	if len(current.Weather) > 0 {
		tooltip.WriteString(fmt.Sprintf("%s %s\n", icon, titleCase(current.Weather[0].Description)))
	}
	tooltip.WriteString(fmt.Sprintf("Feels like: %.0f°C\n", current.Main.FeelsLike))
	tooltip.WriteString(fmt.Sprintf("Humidity: %d%%\n", current.Main.Humidity))
	tooltip.WriteString(fmt.Sprintf("Wind: %.1f m/s\n", current.Wind.Speed))
	tooltip.WriteString("\n<b>Forecast</b>\n")

	// Current hour for comparison
	now := time.Now()
	currentHour := now.Hour()

	type dayData struct {
		min, max     float64
		weatherID    int
		closestDelta int
		hasWeather   bool
	}
	days := make(map[string]*dayData)
	var dayOrder []string

	for _, item := range forecast.List {
		t := time.Unix(item.Dt, 0)
		dayKey := t.Format("Mon 02")

		d, exists := days[dayKey]
		if !exists {
			dayOrder = append(dayOrder, dayKey)
			d = &dayData{
				min:          item.Main.TempMin,
				max:          item.Main.TempMax,
				closestDelta: 24,
			}
			days[dayKey] = d
		}

		if item.Main.TempMin < d.min {
			d.min = item.Main.TempMin
		}
		if item.Main.TempMax > d.max {
			d.max = item.Main.TempMax
		}

		// Pick weather closest to current hour
		if len(item.Weather) > 0 {
			entryHour := t.Hour()
			delta := int(math.Abs(float64(entryHour - currentHour)))
			if delta < d.closestDelta {
				d.closestDelta = delta
				d.weatherID = item.Weather[0].ID
				d.hasWeather = true
			}
		}
	}

	for _, day := range dayOrder {
		d := days[day]
		dayIcon := "🌡️"
		if d.hasWeather {
			dayIcon = getIcon(d.weatherID, getDayNight())
		}
		tooltip.WriteString(fmt.Sprintf("%s  %s  %.0f° / %.0f°\n",
			dayIcon,
			day,
			d.min,
			d.max,
		))
	}

	output := WaybarOutput{
		Text:    text,
		Tooltip: strings.TrimSpace(tooltip.String()),
		Class:   "weather",
	}

	json.NewEncoder(os.Stdout).Encode(output)
}

func fetchJSON[T any](client *http.Client, url string) (*T, error) {
	resp, err := client.Get(url)
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()

	if resp.StatusCode != 200 {
		return nil, fmt.Errorf("API error: %d", resp.StatusCode)
	}

	var data T
	if err := json.NewDecoder(resp.Body).Decode(&data); err != nil {
		return nil, err
	}
	return &data, nil
}

func outputError(msg string) {
	output := WaybarOutput{
		Text:    "⚠️ N/A",
		Tooltip: msg,
		Class:   "weather-error",
	}
	json.NewEncoder(os.Stdout).Encode(output)
}
