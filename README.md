# Expolanets as JSON

This repo grabs data from Caltech IPAC's Exoplanet Archive and stores the information as JSON.

# Usage

First, you'll want to clone the repository:

```shell
$ git clone git@github.com:BenMorganIO/exoplanets.git
```

Once you have a copy, you can enter IRB and load it as so:

```ruby
load './lib/exoplanets.rb'
```

There are two methods for `Exoplanets`:

1. `#all`
  This method will grab all the tables that IPAC has and store it in JSON. Example:
  ```ruby
  Exoplanets.all
  # Now you get to wait for a bit...
  ```
2. `#table`
  This method takes in one parameter (the table name) and will store the information for you. Example:
  ```ruby
  Exoplanets.table :exoplanets
  # Now you have data on all of the confirmed exoplanets
  ```

You may find it useful to run this as a cronjob daily and to store the data not in JSON, but in Redis.

# Data Format

The JSON data looks as so:

```json
"cf3a2b17-9482-488e-8a96-1dcecb6a57a6": {
  "pl_hostname": "Kepler-138",
  "pl_letter": "d",
  "pl_discmethod": "Transit",
  "pl_pnum": "3",
  "pl_orbper": "23.08933000",
  "pl_orbpererr1": "0.00071000",
  "pl_orbpererr2": "-0.00071000",
  "pl_orbperlim": "0",
  "pl_orbpern": "1",
  "pl_orbsmax": null,
  "pl_orbsmaxerr1": null,
  "pl_orbsmaxerr2": null,
  "pl_orbsmaxlim": null,
  "pl_orbsmaxn": "0",
  "pl_orbeccen": "0.024000",
  "pl_orbeccenerr1": "0.030000",
  "pl_orbeccenerr2": "-0.016000",
  "pl_orbeccenlim": "0",
  "pl_orbeccenn": "1",
  "pl_orbincl": null,
  "pl_orbinclerr1": null,
  "pl_orbinclerr2": null,
  "pl_orbincllim": null,
  "pl_orbincln": "0",
  "pl_massj": "0.00300",
  "pl_massjerr1": "0.00100",
  "pl_massjerr2": "-0.00100",
  "pl_massjlim": "0",
  "pl_massn": "1",
  "pl_msinij": null,
  "pl_msinijerr1": null,
  "pl_msinijerr2": null,
  "pl_msinijlim": null,
  "pl_msinin": "0",
  "pl_radj": "0.144",
  "pl_radjerr1": "0.014",
  "pl_radjerr2": "-0.013",
  "pl_radjlim": "0",
  "pl_radn": "1",
  "pl_dens": "1.31000",
  "pl_denserr1": "0.82000",
  "pl_denserr2": "-0.54000",
  "pl_denslim": "0",
  "pl_densn": "1",
  "pl_ttvflag": "1",
  "pl_kepflag": "1",
  "ra_str": "19h21m31.57s",
  "dec_str": "+43d17m34.7s",
  "ra": "290.381561",
  "st_raerr": "0.000017",
  "dec": "43.292973",
  "st_decerr": "0.000017",
  "st_posn": "2",
  "st_dist": null,
  "st_disterr1": null,
  "st_disterr2": null,
  "st_distlim": null,
  "st_distn": "0",
  "st_vj": null,
  "st_vjerr": null,
  "st_vjlim": null,
  "st_vjblend": null,
  "st_teff": "4079.00",
  "st_tefferr": "238.00",
  "st_tefflim": "0",
  "st_teffblend": "0",
  "st_teffn": "3",
  "st_mass": "0.57",
  "st_masserr": "0.05",
  "st_masslim": "0",
  "st_massblend": "0",
  "st_massn": "3",
  "st_rad": "0.53",
  "st_raderr": "0.04",
  "st_radlim": "0",
  "st_radblend": "0",
  "st_radn": "4",
  "hd_name": null,
  "hip_name": null
}
```

The key to the exoplanet is a universal unique identifier (UUID). There are, I believe, 78 keys inside of each exoplanet hash.

# Tables

There are currently 12 tables that this library can parse:

* Confirmed planets:
  * exoplanets

* Kepler Objects of Interest (KOI)
  * cumulative
  * q1_q16_koi
  * q1_q12_koi
  * q1_q8_koi
  * q1_q6_koi

* Threshold-Crossing Events (TCEs)
  * q1_q16_tce
  * q1_q12_tce

* Kepler Names, Kepler Stellar Properties and Kepler Time Series
  * keplerstellar
  * q1_q16_stellar
  * q1_q12_stellar
  * keplernames

Have fun :)
