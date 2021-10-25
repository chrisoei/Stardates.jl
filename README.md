# Stardates

```
julia> using Stardates

julia> Stardate()
Stardate(2021.800063863648, "2021.800063863647893", "2021.800")

julia> Stardate(year = 2010, month = 5, day = 6, hour = 14, minute = 45,
           tz = "America/New_York")
Stardate(2010.3446061643835, "2010.344606164383549", "2010.345")

julia> mstardate(".")
Stardate(2021.800059999239, "2021.800059999239011", "2021.800")

julia> nyse_closing_stardate("2010-05-06")
2010.3447488584475

```
