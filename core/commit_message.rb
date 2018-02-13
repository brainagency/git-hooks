class CommitMessage
  include Constants

  attr_reader :raw_message

  def initialize(raw_message)
    @raw_message = raw_message
  end

  def main_line_has_issue_number?
    main_line.match ISSUE_REGEX
  end

  def main_line_exceeds_length?
    main_line.length > MAIN_LINE_MAX_LENGTH
  end

  def additional_lines_has_issue_number?
    additional_lines_joined.match ISSUE_REGEX
  end

  def additional_lines_skips_issue_number?
    additional_lines_joined.match NO_ISSUE_REGEX
  end

  def additional_lines_has_description?
    length_of_just_description = additional_lines_joined
      .gsub(ISSUE_REGEX, '')
      .gsub(NO_ISSUE_REGEX, '')
      .chomp.strip.length
    length_of_just_description > LENGTH_OF_DESCRIPTION_THRESHOLD
  end

  def additional_lines_skips_description?
    additional_lines_joined.match NO_DESCRIPTION_REGEX
  end

  def lines_without_comments
    @_message_lines_without_comments ||= raw_message
      .split("\n")
      .select { |line| !COMMENT_LINE_REGEX.match(line) }
  end

  def main_line
    lines_without_comments[0]
  end

  def additional_lines_joined
    lines_without_comments[1..-1].join("")
  end
end

