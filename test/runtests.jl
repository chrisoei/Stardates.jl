using Stardates
using Test
using TimeZones

@testset "Stardates.jl" begin
    @test Stardates.millisecond > 0.0
    @test length(canonical(SD())) == 20
    @test length(short(SD())) == 8
    @test abs(SD(ZonedDateTime(2019, 8, 26, 19, 33, 42, tz"America/Los_Angeles")).sd -
            2019.652347222222261) < 3.0 * Stardates.second
end
