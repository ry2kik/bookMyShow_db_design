# BookMyShow Database Design

A comprehensive MySQL database design for a movie ticketing platform (BookMyShow) that manages movies, theatres, shows, screens, and timing information.

## Overview

This project implements a relational database schema for an online movie ticket booking system. It handles the management of cities, theatres, movies, screens, show timings, and related operations.

## Database Schema

### Tables

#### 1. **city**
Stores information about cities where theatres are located.
- `city_id` (INT, PRIMARY KEY, AUTO_INCREMENT): Unique identifier for each city
- `city_name` (VARCHAR(50), NOT NULL, UNIQUE): Name of the city

#### 2. **theatre**
Stores information about theatres.
- `theatre_id` (INT, PRIMARY KEY, AUTO_INCREMENT): Unique identifier for each theatre
- `theatre_name` (VARCHAR(50), NOT NULL): Name of the theatre
- `city_id` (INT, NOT NULL, FOREIGN KEY): References the city where theatre is located

#### 3. **movie**
Stores information about movies.
- `movie_id` (INT, PRIMARY KEY, AUTO_INCREMENT): Unique identifier for each movie
- `movie_name` (VARCHAR(50), NOT NULL): Name of the movie
- `movie_language` (VARCHAR(50)): Language of the movie
- `movie_format` (VARCHAR(10)): Format of the movie (2D, 3D, IMAX, etc.)

#### 4. **screen**
Stores information about screens within theatres.
- `screen_id` (INT, PRIMARY KEY, AUTO_INCREMENT): Unique identifier for each screen
- `theatre_id` (INT, NOT NULL, FOREIGN KEY): References the theatre
- `screen_number` (INT, NOT NULL): Screen number within the theatre
- **Unique Constraint**: `(theatre_id, screen_number)` ensures each screen is unique per theatre

#### 5. **movie_show**
Stores information about movie shows (when and where a movie is playing).
- `show_id` (INT, PRIMARY KEY, AUTO_INCREMENT): Unique identifier for each show
- `movie_id` (INT, NOT NULL, FOREIGN KEY): References the movie being shown
- `theatre_id` (INT, NOT NULL, FOREIGN KEY): References the theatre showing the movie
- `show_date` (DATE, NOT NULL): Date of the show
- **Unique Constraint**: `(movie_id, theatre_id, show_date)` ensures a movie is shown only once per theatre per date

#### 6. **show_timing**
Stores timing information for each show on different screens.
- `show_timing_id` (INT, PRIMARY KEY, AUTO_INCREMENT): Unique identifier for each show timing
- `show_id` (INT, NOT NULL, FOREIGN KEY): References the movie show
- `screen_id` (INT, NOT NULL, FOREIGN KEY): References the screen
- `start_time` (TIME, NOT NULL): Start time of the show
- **Unique Constraint**: `(screen_id, start_time)` ensures no two shows start at the same time on the same screen

## Entity Relationships

```
city (1) ──── (N) theatre
                    │
                    ├──── (N) movie_show ──── (N) movie
                    │         │
                    └─────────┘
                              │
                        (N) show_timing (N)
                              │
                              └──── (N) screen
                                    │
                                    └──── (N) theatre
```

## Sample Data

The database includes sample data for:
- **Cities**: Kolkata, Bengaluru
- **Theatres**: PVR: Nexus Forum Mall (Kolkata)
- **Movies**: Dasara, Kisi Ka Bhai Kisi Ki Jaan, Tu Jhoothi Main Makkaar, Avatar: The Way of Water
- **Screens**: 3 screens in PVR: Nexus Forum Mall
- **Shows**: Multiple shows scheduled for April 25, 2023
- **Show Timings**: Various start times across different screens

## Example Query

Get all movies showing in a specific theatre on a specific date with their timings:

```sql
SELECT
    m.movie_name,
    m.movie_language,
    m.movie_format,
    st.start_time,
    sh.show_date,
    sc.screen_number
FROM theatre t
JOIN movie_show sh ON sh.theatre_id = t.theatre_id
JOIN movie m ON m.movie_id = sh.movie_id
JOIN show_timing st ON st.show_id = sh.show_id
JOIN screen sc ON sc.screen_id = st.screen_id
WHERE
    t.theatre_name = 'PVR: Nexus Forum Mall'
    AND sh.show_date = '2023-04-25'
ORDER BY
    m.movie_name,
    st.start_time;
```

## Key Constraints

- **Foreign Key Constraints**: Ensure referential integrity between related tables
- **Unique Constraints**: Prevent duplicate entries for:
  - City names
  - Theatre screen combinations
  - Movie show dates per theatre
  - Screen start times

## Usage

1. Connect to your MySQL database
2. Run the SQL script from `MySQL Local.session.sql` to create the schema and insert sample data
3. Use the provided queries to retrieve information about movies, shows, and timings

## Files

- `MySQL Local.session.sql`: Complete SQL script with table definitions and sample data
- `README.md`: This documentation file