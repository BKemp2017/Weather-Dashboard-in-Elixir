defmodule WeatherDashboardTest do
  use ExUnit.Case
  doctest WeatherDashboard

  test "greets the world" do
    assert WeatherDashboard.hello() == :world
  end
end
