RSpec.describe GbTrainNetwork::SegmentCalculator do
  # TODO: I think a better way to do this is to have a segment passed two stations to
  # see if the segment is valid for them. This eliminates need to create additional segments
  # segment_a.matches_stations?(station_1, station_2) => true
  # segment_a.matches_stations?(station_2, station_1) => true
  it "can determine if two segment objects represent the same network segment bidirectionally" do
    # TODO: install rspec-mocks and use verifying doubles
    station_1 = GbTrainNetwork::Station.new(1, "1", {})
    station_2 = GbTrainNetwork::Station.new(2, "2", {})
    station_3 = GbTrainNetwork::Station.new(3, "3", {})
    segment_a = GbTrainNetwork::Segment.new(source_station: station_1, target_station: station_2)
    segment_b = GbTrainNetwork::Segment.new(source_station: station_2, target_station: station_1)
    segment_c = GbTrainNetwork::Segment.new(source_station: station_2, target_station: station_3)
    segment_d = GbTrainNetwork::Segment.new(source_station: station_2, target_station: station_3)


    expect(segment_a.matches_bidirectionally?(segment_b)).to eq(true)
    expect(segment_b.matches_bidirectionally?(segment_c)).to eq(false)
    expect(segment_c.matches_bidirectionally?(segment_d)).to eq(true)
  end
  
  it "returns all network segment information in an array" do
    calculator = described_class.new(stations)
    calculator.segments.each do |segment|
      pp [segment.source_station, segment.target_station]
      expected_segment = expected_segments.find do |e_segment| 
        segment.matches_bidirectionally?(e_segment)
      end

      expect(expected_segment).to_not be_nil
    end

    expect(calculator.segments.length).to eq(expected_segments.length)
  end

  def stations
    station_data.map do |station_datum|
      GbTrainNetwork::Station.new(
        station_datum[:id],
        station_datum[:name],
        {},
        station_datum[:connections]
      )
    end
  end

  def expected_segments
    expected_segment_data.map do |expected_segment_datum|
      GbTrainNetwork::Segment.new(
        source_station: expected_segment_datum[0],
        target_station: expected_segment_datum[1]
      )
    end
  end

  def station_data
    [
      {id: 1, name: "A", connections: [2,4,5,6]},
      {id: 2, name: "B", connections: [1,3]},
      {id: 3, name: "C", connections: [2,4,6]},
      {id: 4, name: "D", connections: [1,3]},
      {id: 5, name: "E", connections: [1]},
      {id: 6, name: "F", connections: [1,3]}
    ]
  end

  def expected_segment_data
    [
      [1,2],
      [1,4],
      [1,5],
      [1,6],
      [2,3],
      [3,4],
      [3,6]
    ]
  end
end