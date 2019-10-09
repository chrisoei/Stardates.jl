struct SD
  sd::Float64
end

function SD(zdt::ZonedDateTime)
  tx = astimezone(zdt, tz"UTC")
  y0 = year(tx)
  t0 = Stardates.getstartofyear(y0).zoneddatetime
  t1 = Stardates.getstartofyear(y0 + 1).zoneddatetime
  SD(y0 + (tx - t0)/(t1 - t0))
end

function SD(dt::Dates.DateTime)
  # Assume dt is in UTC
  y0 = Dates.year(dt)
  t0 = Stardates.getstartofyear(y0).unix
  t1 = Stardates.getstartofyear(y0 + 1).unix
  SD(y0 + (Dates.datetime2unix(dt) - t0)/(t1 - t0))
end

function SD(d::Dates.Date, hr, mi, ss, tz)
  SD(ZonedDateTime(Dates.year(d), Dates.month(d), Dates.day(d),
       hr, mi, ss, tz))
end

"Return the stardate of the closing bell of the date"
function nyse_closing_stardate(d::Dates.Date)
  SD(d, 16, 0, 0, tz"America/New_York").sd
end

"Return the stardate of the closing bell of the date represented by iso8601"
function nyse_closing_stardate(iso8601)
  nyseclosingstardate(parse(Dates.Date, iso8601)).sd
end

function SD(st::Base.StatStruct)
  SD(Dates.unix2datetime(st.mtime))
end

function SD()
  SD(now(tz"UTC"))
end

function canonical(sd::SD)
  Printf.@sprintf("%0.15f", sd.sd)
end

function short(sd::SD)
  Printf.@sprintf("%0.3f", sd.sd)
end
