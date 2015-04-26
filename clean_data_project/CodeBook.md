## Codebook for grouped_measurements.txt

See `run_analysis.R` for documented steps of how `grouped_measurements.txt` is created.

See `README.md` for providence and summary information about the data.

The file will contain the following columns:

- **subject**: The subject from either the train or test dataset
- **activity**: The activity name the given subject was performing
- **[79 remaining columns]**: The average of the measurements with the provided names for the given *subject* and *activity*.

Only measurements with `std` or `mean` in their heading are provided.

See `features_info.txt` in original data file (referenced in `README.md`) for description
of these fields.
