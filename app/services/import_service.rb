class ImportService
  def initialize(scoring_sheet, score_file)
  	@scoring_sheet = scoring_sheet
    @score_file = score_file
  end

  def run
    File.open(@score_file, "r").each_line do |line|
      data = line.split
      next unless data[0]
      build_report(data) if data[0].downcase == "report"
      build_track(data) if data[0].downcase == "track"
      build_indicator(data) if data[0].downcase == "indicator"
    end
  end

  def build_report(data)
    Report.create!(scoring_sheet: @scoring_sheet, external_id: data[1])
  end

  def build_track(data)
    report = @scoring_sheet.reports.find_by(scoring_sheet: @scoring_sheet, external_id: data[2])
    Track.create!(report: report, external_id: data[1], track_name: data[3])
  end

  def build_indicator(data)
    track = @scoring_sheet.tracks.find_by(external_id: data[2])
    Indicator.create!(track: track, external_id: data[1], score: data[3], weight: data[4])
  end	
end
