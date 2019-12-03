DROP TABLE IF EXISTS property_tracker;

CREATE TABLE property_tracker (
  id SERIAL PRIMARY KEY,
  address VARCHAR(255),
  value INT,
  number_of_bedrooms INT,
  year_built VARCHAR(255)

);
