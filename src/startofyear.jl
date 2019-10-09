startofyear = Dict{Int64,Any}()
function getstartofyear(y)
  if haskey(startofyear, y)
    return startofyear[y]
  end
  dt = Dates.DateTime(y, 1, 1, 0, 0, 0)
  startofyear[y] = (
    datetime = dt,
    unix = Dates.datetime2unix(dt),
    zoneddatetime = ZonedDateTime(dt, tz"UTC"),
  )
end
