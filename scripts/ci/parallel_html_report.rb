require 'erb'

def find_reports
  @reports = Dir.glob('html-report/report*.html')
  @reports.map! do |path|
    rindex = path.rindex '/'
    rindex = 0 if rindex < 0
    path[rindex+1..path.length]
  end
  @default_report = @reports[0]
end

def render_nav_html
  find_reports if @reports.nil?

  navTemplate = File.open('scripts/ci/nav.html.tpl', 'r')
  renderer = ERB.new(navTemplate.read)
  navTemplate.close
  navHtml = File.open('html-report/nav.html', 'w')
  navHtml.write renderer.result
  navHtml.close
end

def render_parallel_report
  find_reports if @default_report.nil?

  render_nav_html

  parallelTpl = File.open('scripts/ci/report_merged.html.tpl')
  renderer = ERB.new(parallelTpl.read)
  parallelTpl.close
  parallelHtml = File.open('html-report/report_merged.html', 'w')
  parallelHtml.write renderer.result
  parallelHtml.close
end