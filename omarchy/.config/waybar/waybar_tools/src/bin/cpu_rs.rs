// Put this on your waybar config.jsonc
// then add "custom/cpu" to any of the modules (modules-left, modules-right, modules-center)
// "custom/cpu": {
//   "exec": "~/.config/waybar/waybar_tools/target/release/cpu_rs",
//   "interval": 5,
//   "return-type": "json"
// },
use serde_json::json;
use std::{fs, thread};
use sysinfo::{Components, System};

fn read_gpu_temp() -> Option<f32> {
    let paths = fs::read_dir("/sys/class/hwmon").ok()?;

    for entry in paths {
        let path = entry.ok()?.path();

        let name_path = path.join("name");
        let name = fs::read_to_string(name_path).unwrap_or_default();

        // Try to detect GPU sensors
        if name.contains("amdgpu") || name.contains("nouveau") || name.contains("i915") {
            for i in 1..=5 {
                let temp_path = path.join(format!("temp{}_input", i));

                if let Ok(temp_str) = fs::read_to_string(temp_path) {
                    if let Ok(temp) = temp_str.trim().parse::<f32>() {
                        return Some(temp / 1000.0); // millidegrees → °C
                    }
                }
            }
        }
    }

    None
}

fn read_amd_gpu_usage() -> Option<f32> {
    let entries = fs::read_dir("/sys/class/drm").ok()?;

    for entry in entries {
        let path = entry.ok()?.path();

        if path.file_name()?.to_str()?.starts_with("card") {
            let usage_path = path.join("device/gpu_busy_percent");

            if let Ok(content) = fs::read_to_string(usage_path) {
                if let Ok(val) = content.trim().parse::<f32>() {
                    return Some(val);
                }
            }
        }
    }

    None
}

fn main() {
    let mut sys = System::new_all();
    sys.refresh_cpu_all();
    thread::sleep(sysinfo::MINIMUM_CPU_UPDATE_INTERVAL); // ~200ms
    sys.refresh_cpu_all();

    // CPU data
    let cpu_usage = sys.global_cpu_usage(); // f32, 0.0–100.0
    let components = Components::new_with_refreshed_list();
    let cpu_temp = components
        .iter()
        .find(|c| c.label() == "k10temp Tctl")
        .and_then(|c| c.temperature())
        .unwrap();

    // GPU data
    let gpu_temp = read_gpu_temp().unwrap();

    let gpu_usage = read_amd_gpu_usage().unwrap();

    let tooltip = [
        format!("<b>󰻠 CPU</b>"),
        format!("  Usage:       {:.0}%", cpu_usage),
        format!("  Temperature: {:.0}°C", cpu_temp),
        format!("\n<b>󰍛 GPU</b>"),
        format!("  Usage:       {:.0}%", gpu_usage),
        format!("  Temperature: {:.0}°C", gpu_temp),
    ]
    .join("\n");

    let output = json!({
        "text": format!("<b>CPU</b> {:.0}% <b>GPU</b> {:.0}%", cpu_usage, gpu_usage),
        "tooltip": tooltip,
        "class": "test"
    });

    print!("{}", output);
}
