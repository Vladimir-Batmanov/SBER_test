import requests

def fetch_country_data(url='https://restcountries.com/v3.1/all'):
    # Получаем данные о странах с API
    response = requests.get(url)
    response.raise_for_status()  # Обрабатываем ошибку HTTP, если она есть
    return response.json()

def calculate_average_population(countries):
    # Рассчитываем среднее население всех стран
    total_population = sum(country.get('population', 0) for country in countries)
    return total_population / len(countries)

def filter_countries_by_language_and_population(countries, language_name, average_population):
    # Фильтруем страны, где указанный язык является официальным и население выше среднего
    return [
        {'name': country['name']['common'], 'population': country['population']}
        for country in countries
        if language_name in country.get('languages', {}).values() and country['population'] > average_population
    ]

def main():
    countries = fetch_country_data()
    average_population = calculate_average_population(countries)
    russian_speaking_countries = filter_countries_by_language_and_population(countries, 'Russian', average_population)
    
    for country in russian_speaking_countries:
        print(f"{country['name']}: {country['population']}")

if __name__ == "__main__":
    main()
