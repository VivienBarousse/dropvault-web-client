module ApplicationHelper

  def to_human_size(size)
    size_units = ["Kb", "Mb", "Gb", "Tb"]

    final_unit = "b"
    size_units.each do |unit|
      if size > 1024
        final_unit = unit
        size /= 1024
      end
    end
    sprintf("%.1f %s", size, final_unit)
  end

end
