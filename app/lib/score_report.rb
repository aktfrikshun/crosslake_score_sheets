module ScoreReport
 
  def self.generate(ccompany_name, score_file)
    scoring_sheet = ScoringSheet.create!(name: @company_name)
    ImportService.new(scoring_sheet, score_file).run
    ScoringService.new(scoring_sheet).run
    print_to_console(scoring_sheet)
  end
 
  def self.print_to_console(scoring_sheet)
    scoring_sheet.reports.each do | report |
      puts "Report #{report.external_id} Overall Score: #{report.score}"
      report.tracks.each do | track |
        puts "Track #{track.external_id} Score: #{track.score}"
      end
    end 
  end
end
