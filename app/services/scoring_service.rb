class ScoringService
  def initialize(scoring_sheet)
    @scoring_sheet = scoring_sheet
  end

  def run
    score_tasks
    score_reports
  end

  def score_tasks
    @scoring_sheet.tracks.each do | track |
      total_score = track.indicators.inject(0){|sum,e| sum + (e.weight * e.score) }
      divisor = track.indicators.inject(0){|sum,e| sum + e.weight }
      track.score = (total_score / divisor).round(2)
      track.save!
    end
  end

  def score_reports
    @scoring_sheet.reports.each do | report |
      total_score = report.tracks.inject(0){|sum,e| sum + e.score}
      divisor = report.tracks.count
      report.score = (total_score / divisor).round(2)
      report.save!
    end    
  end

end
