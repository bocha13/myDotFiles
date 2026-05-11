// Build: go build -o ~/.config/waybar/weather ./cmd/weather
//
//	Put this on your waybar config.jsonc
//	then add "custom/weather" to any of the modules (modules-left, modules-right or modules-center)
//
//	 "custom/weather": {
//	   "exec": "~/.config/waybar/weather",
//	   "interval": 600,
//	   "return-type": "json",
//	   "id": "custom-weather"
//	 },
package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"strings"
	"time"
)

type WaybarOutput struct {
	Text    string `json:"text"`
	Tooltip string `json:"tooltip"`
	Class   string `json:"class"`
}

const apiURL = "https://api.open-meteo.com/v1/forecast" +
	"?latitude=-31.6488&longitude=-60.7087" +
	"&daily=weather_code,temperature_2m_max,temperature_2m_min" +
	"&current=temperature_2m,is_day,weather_code,apparent_temperature,relative_humidity_2m,wind_speed_10m" +
	"&timezone=America%2FSao_Paulo&past_days=0&forecast_days=7"

type OpenMeteoResponse struct {
	Current struct {
		Temperature      float64 `json:"temperature_2m"`
		IsDay            int     `json:"is_day"`
		WeatherCode      int     `json:"weather_code"`
		ApparentTemp     float64 `json:"apparent_temperature"`
		RelativeHumidity int     `json:"relative_humidity_2m"`
		WindSpeed        float64 `json:"wind_speed_10m"`
	} `json:"current"`
	Daily struct {
		Time        []string  `json:"time"`
		WeatherCode []int     `json:"weather_code"`
		TempMax     []float64 `json:"temperature_2m_max"`
		TempMin     []float64 `json:"temperature_2m_min"`
	} `json:"daily"`
}

// WMO weather code to emoji icon
func getIcon(code int, isDay bool) string {
	switch {
	case code == 0:
		if isDay {
			return ""
		}
		return ""
	case code <= 2:
		if isDay {
			return ""
		}
		return ""
	case code == 3:
		return ""
	case code >= 45 && code <= 48:
		return ""
	case code >= 51 && code <= 57:
		if isDay {
			return ""
		}
		return ""
	case code >= 61 && code <= 67:
		return ""
	case code >= 71 && code <= 77:
		if isDay {
			return ""
		}
		return ""
	case code >= 80 && code <= 82:
		return ""
	case code == 85 || code == 86:
		if isDay {
			return ""
		}
		return ""
	case code >= 95 && code <= 99:
		return ""
	default:
		return "🌡️"
	}
}

func main() {
	client := &http.Client{Timeout: 10 * time.Second}

	var data *OpenMeteoResponse
	var err error
	for range 3 {
		data, err = fetchJSON[OpenMeteoResponse](client, apiURL)
		if err == nil {
			break
		}
		time.Sleep(5 * time.Second)
	}
	if err != nil {
		outputError(err.Error())
		return
	}

	c := data.Current
	isDay := c.IsDay == 1
	icon := getIcon(c.WeatherCode, isDay)

	text := fmt.Sprintf("%s %.0f°C", icon, c.Temperature)

	var tooltip strings.Builder
	tooltip.WriteString(fmt.Sprintf("<b>Santa Fe, AR</b>\n"))
	tooltip.WriteString(fmt.Sprintf("%s %s\n", icon, wmoDescription(c.WeatherCode)))
	tooltip.WriteString(fmt.Sprintf("Feels like: %.0f°C\n", c.ApparentTemp))
	tooltip.WriteString(fmt.Sprintf("Humidity: %d%%\n", c.RelativeHumidity))
	tooltip.WriteString(fmt.Sprintf("Wind: %.1f km/h\n", c.WindSpeed))
	tooltip.WriteString("\n<b>Forecast</b>\n")

	for i, t := range data.Daily.Time {
		if i >= len(data.Daily.WeatherCode) {
			break
		}
		parsed, parseErr := time.Parse("2006-01-02", t)
		dayLabel := t
		if parseErr == nil {
			dayLabel = parsed.Format("Mon 02")
		}
		dayIcon := getIcon(data.Daily.WeatherCode[i], true)
		tooltip.WriteString(fmt.Sprintf("%s  %s  %.0f° / %.0f°\n",
			dayIcon,
			dayLabel,
			data.Daily.TempMin[i],
			data.Daily.TempMax[i],
		))
	}

	output := WaybarOutput{
		Text:    text,
		Tooltip: strings.TrimSpace(tooltip.String()),
		Class:   "weather",
	}
	json.NewEncoder(os.Stdout).Encode(output)
}

func wmoDescription(code int) string {
	switch {
	case code == 0:
		return "Clear Sky"
	case code == 1:
		return "Mainly Clear"
	case code == 2:
		return "Partly Cloudy"
	case code == 3:
		return "Overcast"
	case code == 45:
		return "Fog"
	case code == 48:
		return "Icy Fog"
	case code >= 51 && code <= 53:
		return "Drizzle"
	case code >= 55 && code <= 57:
		return "Heavy Drizzle"
	case code >= 61 && code <= 63:
		return "Rain"
	case code == 65:
		return "Heavy Rain"
	case code == 66 || code == 67:
		return "Freezing Rain"
	case code >= 71 && code <= 73:
		return "Snow"
	case code == 75:
		return "Heavy Snow"
	case code == 77:
		return "Snow Grains"
	case code >= 80 && code <= 82:
		return "Rain Showers"
	case code == 85 || code == 86:
		return "Snow Showers"
	case code == 95:
		return "Thunderstorm"
	case code == 96 || code == 99:
		return "Thunderstorm with Hail"
	default:
		return "Unknown"
	}
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
