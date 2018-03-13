module Constants
  # Issue code pattern.
  # For example:
  #   * in Jira each project has a code.
  #     So an issue code in a particular project will be `<PROJECT-CODE>-<ISSUE-NUMBER>`.
  ISSUE_REGEX = /#{GIT_HOOKS_PROJECT_CODE}-\d*/
  NO_ISSUE_REGEX = /\[no-issue\]/
  NO_DESCRIPTION_REGEX = /\[no-description\]|\[no-desc\]/
  COMMENT_LINE_REGEX = /^\#.*/
  MAIN_LINE_MAX_LENGTH = 50
  LENGTH_OF_DESCRIPTION_THRESHOLD = 2
  PROJECT_ROOT_PATH = File.expand_path(__FILE__).gsub(/(\.git.*)/, '').freeze
  WRONG_COMMIT_MSG_RELATIVE_PATH = '.git/COMMIT_EDITMSG_WRONG'.freeze
end
