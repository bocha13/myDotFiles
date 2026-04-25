// Put this on your waybar config.jsonc
// then add "custom/weather" to any of the modules (modules-left, modules-right, modules-center)
// "custom/weather": {
//   "exec": "~/.config/waybar/waybar_tools/target/release/weather_rs",
//   "interval": 600, // refresh every 10 min
//   "return-type": "json",
//   "id": "custom-weather",
//   "tooltip": true
// },
use chrono::NaiveDate;
use reqwest::blocking::Client;
use serde::Deserialize;
use serde_json::json;

#[derive(Deserialize)]
struct Data {
    current: Current,
    daily: Daily,
}

#[derive(Deserialize)]
struct Current {
    temperature_2m: f32,
    is_day: u32,
    weather_code: u32,
    apparent_temperature: f32,
    relative_humidity_2m: u32,
    wind_speed_10m: f32,
}

#[derive(Deserialize)]
struct Daily {
    time: Vec<String>,
    weather_code: Vec<u32>,
    temperature_2m_max: Vec<f32>,
    temperature_2m_min: Vec<f32>,
}

fn weather_icon(code: u32, is_day: Option<u32>) -> &'static str {
    match code {
        0 => match is_day {
            Some(1) => "☀️",
            Some(0) => "🌙",
            Some(_) => "☀️",
            None => "☀️",
        },
        1 | 2 => "⛅",
        3 => "☁️",
        45 | 48 => "🌫️",
        51 | 53 | 55 => "🌦️",
        61 | 63 | 65 => "🌧️",
        71 | 73 | 75 => "❄️",
        95 | 96 | 99 => "⛈️",
        _ => "🌍",
    }
}

fn weather_description(code: u32) -> &'static str {
    match code {
        0 => "Clear Sky",
        1 => "Mainly Clear",
        2 => "Partly Cloudy",
        3 => "Overcast",
        45 | 48 => "Fog",
        51 | 53 | 55 => "Drizzle",
        61 | 63 | 65 => "Rain",
        66 | 67 => "Freezing Rain",
        71 | 73 | 75 => "Snow Fall",
        77 => "Snow Grains",
        80 | 81 | 82 => "Rain Shower",
        85 | 86 => "Snow Shower",
        95 | 96 | 99 => "Thunderstorm",
        _ => "N/A",
    }
}

fn get_day(s: &str) -> String {
    let date = NaiveDate::parse_from_str(s, "%Y-%m-%d").unwrap();
    date.format("%a").to_string()
}

fn main() {
    let client = Client::new();
    let endpoint = String::from(
        "https://api.open-meteo.com/v1/forecast?latitude=-31.6488&longitude=-60.7087&daily=weather_code,temperature_2m_max,temperature_2m_min&current=temperature_2m,is_day,weather_code,apparent_temperature,relative_humidity_2m,wind_speed_10m&timezone=America%2FSao_Paulo&past_days=0&forecast_days=7",
    );
    let data: Data = client.get(endpoint).send().and_then(|r| r.json()).unwrap();

    let c = data.current;
    let d = data.daily;

    let forecast_lines: Vec<String> = d
        .time
        .iter()
        .zip(d.weather_code.iter())
        .zip(d.temperature_2m_min.iter())
        .zip(d.temperature_2m_max.iter())
        .map(|(((time, code), min), max)| {
            format!(
                "{} {} {} {:.0}° / {:.0}°",
                weather_icon(*code, None),
                get_day(time),
                time.rsplit("-").next().unwrap_or("??"),
                min,
                max
            )
        })
        .collect();

    let tooltip = [
        format!("<b>Santa Fe</b>"),
        format!(
            "{} {}",
            weather_icon(c.weather_code, Some(c.is_day)),
            weather_description(c.weather_code)
        ),
        format!("Feels Like:    {:.0}°C", c.apparent_temperature),
        format!("Humidity:      {:.0}%", c.relative_humidity_2m),
        format!("Wind:          {:.0} km/h", c.wind_speed_10m),
        format!("\n<b>Forecast</b>"),
    ]
    .into_iter()
    .chain(forecast_lines)
    .collect::<Vec<_>>()
    .join("\n");

    let output = json!({
    "text": format!("{} {:.0}°C", weather_icon(c.weather_code, Some(c.is_day)),c.temperature_2m),
    "tooltip": tooltip,
    });

    println!("{}", output);
}
