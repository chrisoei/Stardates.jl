struct Stardate
  sd::Float64
  canonical::String
  short::String
  originaltz::TimeZones.TimeZone
end

function Stardate(x::Float64, tz1::TimeZone = tz"UTC")
  Stardate(
    x,
    Printf.@sprintf("%0.15f", x),
    Printf.@sprintf("%0.3f", x),
    tz1
  )
end

function Stardate(zdt::ZonedDateTime)
  tx = astimezone(zdt, tz"UTC")
  y0 = year(tx)
  t0 = Stardates.getstartofyear(y0).zoneddatetime
  t1 = Stardates.getstartofyear(y0 + 1).zoneddatetime
  Stardate(y0 + (tx - t0) / (t1 - t0), timezone(zdt))
end

function Stardate(dt::Dates.DateTime)
  # Assume dt is in UTC
  y0 = Dates.year(dt)
  t0 = Stardates.getstartofyear(y0).unix
  t1 = Stardates.getstartofyear(y0 + 1).unix
  Stardate(y0 + (Dates.datetime2unix(dt) - t0) / (t1 - t0))
end

function Stardate(d::Dates.Date, hr, mi, ss, tz)
  Stardate(ZonedDateTime(
    Dates.year(d),
    Dates.month(d),
    Dates.day(d),
    hr,
    mi,
    ss,
    tz,
  ))
end

function Stardate(;
    year,
    month,
    day,
    hour = 12,
    minute = 0,
    second = 0,
    tz = nothing,
    style = nothing,
    copy = false
)
  if tz == nothing
    tz1 = TimeZone(ENV["TZ"])
  else
    tz1 = TimeZone(tz)
  end
  Stardate(ZonedDateTime(year, month, day, hour, minute, second, tz1))
end

function stardate(args...)
  Stardate(args...).sd
end

"Return the stardate of the closing bell of the date"
function nyse_closing_stardate(d::Dates.Date)
  stardate(d, 16, 0, 0, tz"America/New_York")
end

"Return the stardate of the closing bell of the date represented by iso8601"
function nyse_closing_stardate(iso8601)
  nyse_closing_stardate(parse(Dates.Date, iso8601))
end

function Stardate(st::Base.StatStruct)
  Stardate(Dates.unix2datetime(st.mtime))
end

function mstardate(fn::AbstractString)
  Stardate(stat(fn))
end

function Stardate(sy::Symbol)
  Stardate(now(TimeZone(ENV["TZ"])))
end

