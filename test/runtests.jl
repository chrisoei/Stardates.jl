using Stardates
using Test
using TimeZones

@testset "Stardates.jl" begin
    @test Stardates.millisecond > 0.0
    @test length(canonical(SD())) == 20
    @test length(short(SD())) == 8
    @test abs(SD(ZonedDateTime(2019, 8, 26, 19, 33, 42, tz"America/Los_Angeles")).sd -
            2019.652347222222261) < 3.0 * Stardates.second
    @test abs(SD(ZonedDateTime(2012, 1, 2, 3, 4, 5, tz"UTC")).sd -
        2012.0030815181644) < 3.0 * Stardates.second
    @test abs(SD(ZonedDateTime(2014, 9, 30, 17, 17, 27, tz"America/Los_Angeles")).sd -
        2014.747978420491791) < 3.0 * Stardates.second
    @test abs(nyse_closing_stardate("2014-09-30") - 2014.747488584474922) <
        3.0 * Stardates.second
end
