require "application_system_test_case"

class BusesTest < ApplicationSystemTestCase
  setup do
    @bus = buses(:one)
  end

  test "visiting the index" do
    visit buses_url
    assert_selector "h1", text: "Buses"
  end

  test "should create bus" do
    visit buses_url
    click_on "New bus"

    fill_in "Arrival time", with: @bus.arrival_time
    fill_in "Bus no", with: @bus.bus_no
    fill_in "Busname", with: @bus.busname
    fill_in "Destination route", with: @bus.destination_route
    fill_in "Noofseat", with: @bus.noofseat
    fill_in "Owner", with: @bus.owner_id
    fill_in "Source route", with: @bus.source_route
    click_on "Create Bus"

    assert_text "Bus was successfully created"
    click_on "Back"
  end

  test "should update Bus" do
    visit bus_url(@bus)
    click_on "Edit this bus", match: :first

    fill_in "Arrival time", with: @bus.arrival_time
    fill_in "Bus no", with: @bus.bus_no
    fill_in "Busname", with: @bus.busname
    fill_in "Destination route", with: @bus.destination_route
    fill_in "Noofseat", with: @bus.noofseat
    fill_in "Owner", with: @bus.owner_id
    fill_in "Source route", with: @bus.source_route
    click_on "Update Bus"

    assert_text "Bus was successfully updated"
    click_on "Back"
  end

  test "should destroy Bus" do
    visit bus_url(@bus)
    click_on "Destroy this bus", match: :first

    assert_text "Bus was successfully destroyed"
  end
end
