# SBER_test
*Test task from SBER. Block on knowledge of sql and block on knowledge of python.*

# SQL Block. Product Price Stability SQL Analysis

This project involves creating a SQL schema and query to determine the number of days each product's price remained stable. A stable price is defined as a price that changes by no more than 3% from day to day.

### Database Schema

The database consists of two tables:

1. **products**: Contains information about products.
2. **prices**: Stores daily closing prices for each product.

### Table Definitions

```sql
CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255) NOT NULL
);

CREATE TABLE prices (
    price_id INT PRIMARY KEY,
    product_id INT,
    price_date DATE,
    price DECIMAL(10, 2),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);
```

# Python Block. Country Data Analysis

This project fetches country data from the REST Countries API, calculates the average population of all countries, and filters countries where Russian is an official language and the population exceeds the global average. The filtered list of countries is then printed with their names and populations.

### Features

- Fetches data for all countries from the REST Countries API
- Calculates the average population of all countries
- Filters countries by language (Russian) and population (above average)
- Outputs the names and populations of the filtered countries

### Requirements

- `Python` 3.x
- `requests` library

### Installation

1. Clone the repository:
    ```sh
    git clone https://github.com/yourusername/country-data-analysis.git
    cd country-data-analysis
    ```

2. Install the required Python library:
    ```sh
    pip install requests
    ```

### Usage

1. Run the script:
    ```sh
    python python_block.py
    ```

2. The script will output the names and populations of countries where Russian is an official language and the population is above the global average.

### Code Explanation

The main parts of the script are as follows:

- `fetch_country_data(url)`: Fetches country data from the provided API URL.
- `calculate_average_population(countries)`: Calculates the average population of the provided list of countries.
- `filter_countries_by_language_and_population(countries, language_name, average_population)`: Filters countries where the specified language is official and the population is above the average.
- `main()`: The main function that integrates the steps and prints the results.

### Example Output

```plaintext
Russia: 146599183
Kazakhstan: 18754440
```

### Contact

- Telegram: [@vbatmanov](https://t.me/vbatmanov)
- Email: v.a.batmanov@gmail.com
