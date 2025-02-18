class CorporationRepresenter
  def initialize(corporations)
    @corporations = corporations
  end

  def as_json
    corporations.map do |c|
      {
        id: c.id,
        name: c.name,
        location: c.location,
      }
    end
  end

  private

  attr_reader :corporations
end