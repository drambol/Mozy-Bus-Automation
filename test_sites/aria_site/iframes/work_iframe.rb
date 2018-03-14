module Aria
  class WorkIframe < SiteHelper::Iframe

    iframe(:inner_work_if, InnerWorkIframe, :id, 'inner_work_frm')

    section(:side_menu_section, SideMenuSection, id: 'sidebar')

  end
end