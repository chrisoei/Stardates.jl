using Stardates
using Test
using TimeZones

@testset "Stardates.jl" begin
        @test Stardates.millisecond > 0.0
        @test length(canonical(Stardate())) == 20
        @test length(short(Stardate())) == 8
        @test abs(Stardate(ZonedDateTime(
                2019,
                8,
                26,
                19,
                33,
                42,
                tz"America/Los_Angeles",
        )).sd - 2019.652347222222261) < 3.0 * Stardates.second
        @test abs(Stardate(ZonedDateTime(2012, 1, 2, 3, 4, 5, tz"UTC")).sd -
                  2012.0030815181644) < 3.0 * Stardates.second
        @test abs(Stardate(ZonedDateTime(
                2014,
                9,
                30,
                17,
                17,
                27,
                tz"America/Los_Angeles",
        )).sd - 2014.747978420491791) < 3.0 * Stardates.second
        @test abs(nyse_closing_stardate("2014-09-30") -
                  2014.747488584474922) < 3.0 * Stardates.second
        @test abs(Stardate(DateTime(2012, 1, 2, 3, 4, 5)).sd -
                  2012.0030815181644) < 3.0 * Stardates.second

        sd1 = Stardate()
        sleep(1.0)
        f1 = tempname()
        write(f1, "Hello")
        sd2 = Stardate(stat(f1))
        rm(f1)
        sleep(1.0)
        sd3 = Stardate()
        @test sd1.sd <= sd2.sd
        @test sd2.sd <= sd3.sd

    # Test against Python implementation output
        @test stardate(ZonedDateTime(
                2019,
                10,
                11,
                11,
                7,
                0,
                tz"America/Los_Angeles",
        )) ≈ 2019.7774105783867

end
