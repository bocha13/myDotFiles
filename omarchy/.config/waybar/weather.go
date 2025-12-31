package main

// WARN: DON'T FORGET TO SET OWM_API_KEY ON YOUR ENV!!!
// WARN: you need to add the variable to the /etc/environment file
// WARN: because waybar loads before bashrc is called
//
//  Put this on your waybar config.jsonc
//  then add "custom/weather" to any of the modules (modules-left, modules-right or modules-center)
//
//   "custom/weather": {
//     "exec": "~/.config/waybar/weather",
//     "interval": 600, // refresh every 10 min
//     "return-type": "json",
//     "id": "custom-weather"
//   },

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"strings"
	"time"
)

const (
	city  = "Santa%20Fe,AR"
	units = "metric"
)

type WaybarOutput struct {
	Text    string `json:"text"`
	Tooltip string `json:"tooltip"`
	Class   string `json:"class"`
}

type CurrentWeather struct {
	Main struct {
		Temp      float64 `json:"temp"`
		FeelsLike float64 `json:"feels_like"`
		Humidity  int     `json:"humidity"`
	} `json:"main"`
	Weather []struct {
		ID          int    `json:"id"`
		Description string `json:"description"`
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

func getIcon(id int) string {
	switch {
	case id >= 200 && id < 300:
		return "⛈️" // Thunderstorm
	case id >= 300 && id < 400:
		return "🌧️" // Drizzle
	case id >= 500 && id < 600:
		return "🌧️" // Rain
	case id >= 600 && id < 700:
		return "❄️" // Snow
	case id >= 700 && id < 800:
		return "🌫️" // Atmosphere (fog, mist)
	case id == 800:
		return "☀️" // Clear
	case id == 801:
		return "🌤️" // Few clouds
	case id == 802:
		return "⛅" // Scattered clouds
	case id >= 803:
		return "☁️" // Cloudy
	default:
		return "🌡️"
	}
}

func main() {
	apiKey := os.Getenv("OWM_API_KEY")
	if apiKey == "" {
		outputError("OWM_API_KEY not set")
		return
	}

	client := &http.Client{Timeout: 10 * time.Second}

	// Fetch current weather
	currentURL := fmt.Sprintf("https://api.openweathermap.org/data/2.5/weather?q=%s&units=%s&appid=%s", city, units, apiKey)
	current, err := fetchJSON[CurrentWeather](client, currentURL)
	if err != nil {
		outputError(err.Error())
		return
	}

	// Fetch 5-day forecast
	forecastURL := fmt.Sprintf("https://api.openweathermap.org/data/2.5/forecast?q=%s&units=%s&appid=%s", city, units, apiKey)
	forecast, err := fetchJSON[Forecast](client, forecastURL)
	if err != nil {
		outputError(err.Error())
		return
	}

	// Current weather text
	icon := "🌡️"
	if len(current.Weather) > 0 {
		icon = getIcon(current.Weather[0].ID)
	}
	text := fmt.Sprintf("%s %.0f°C", icon, current.Main.Temp)

	// Build tooltip with current + forecast
	var tooltip strings.Builder
	tooltip.WriteString(fmt.Sprintf("<b>%s</b>\n", current.Name))
	if len(current.Weather) > 0 {
		tooltip.WriteString(fmt.Sprintf("%s %s\n", icon, strings.Title(current.Weather[0].Description)))
	}
	tooltip.WriteString(fmt.Sprintf("Feels like: %.0f°C\n", current.Main.FeelsLike))
	tooltip.WriteString(fmt.Sprintf("Humidity: %d%%\n", current.Main.Humidity))
	tooltip.WriteString(fmt.Sprintf("Wind: %.1f m/s\n", current.Wind.Speed))
	tooltip.WriteString("\n<b>Forecast</b>\n")

	// Group forecast by day and get min/max
	days := make(map[string]struct {
		min, max   float64
		id         int
		fallbackID int
	})
	var dayOrder []string

	for _, item := range forecast.List {
		t := time.Unix(item.Dt, 0)
		dayKey := t.Format("Mon 02")

		d, exists := days[dayKey]
		if !exists {
			dayOrder = append(dayOrder, dayKey)
			d = struct {
				min, max   float64
				id         int
				fallbackID int
			}{min: item.Main.TempMin, max: item.Main.TempMax}
		}

		if item.Main.TempMin < d.min {
			d.min = item.Main.TempMin
		}
		if item.Main.TempMax > d.max {
			d.max = item.Main.TempMax
		}

		// Capture first weather as fallback
		if d.fallbackID == 0 && len(item.Weather) > 0 {
			d.fallbackID = item.Weather[0].ID
		}

		// Prefer midday weather (UTC 15-18 = ~12-15 local for AR)
		if t.Hour() >= 15 && t.Hour() <= 18 && len(item.Weather) > 0 {
			d.id = item.Weather[0].ID
		}

		days[dayKey] = d
	}

	for _, day := range dayOrder {
		d := days[day]
		weatherID := d.id
		if weatherID == 0 {
			weatherID = d.fallbackID
		}
		dayIcon := getIcon(weatherID)
		tooltip.WriteString(fmt.Sprintf("%s  %s  %.0f° / %.0f°\n", dayIcon, day, d.max, d.min))
	}
	// days := make(map[string]struct {
	// 	min, max float64
	// 	id       int
	// 	desc     string
	// })
	// var dayOrder []string
	//
	// for _, item := range forecast.List {
	// 	t := time.Unix(item.Dt, 0)
	// 	dayKey := t.Format("Mon 02")
	//
	// 	if _, exists := days[dayKey]; !exists {
	// 		dayOrder = append(dayOrder, dayKey)
	// 		days[dayKey] = struct {
	// 			min, max float64
	// 			id       int
	// 			desc     string
	// 		}{min: item.Main.TempMin, max: item.Main.TempMax}
	// 	}
	//
	// 	d := days[dayKey]
	// 	if item.Main.TempMin < d.min {
	// 		d.min = item.Main.TempMin
	// 	}
	// 	if item.Main.TempMax > d.max {
	// 		d.max = item.Main.TempMax
	// 	}
	// 	// Use midday weather for the icon
	// 	if t.Hour() >= 12 && t.Hour() <= 15 && len(item.Weather) > 0 {
	// 		d.id = item.Weather[0].ID
	// 		d.desc = item.Weather[0].Description
	// 	}
	// 	days[dayKey] = d
	// }

	// for _, day := range dayOrder {
	// 	d := days[day]
	// 	dayIcon := getIcon(d.id)
	// 	tooltip.WriteString(fmt.Sprintf("%s  %s  %.0f° / %.0f°\n", dayIcon, day, d.min, d.max))
	// }

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
