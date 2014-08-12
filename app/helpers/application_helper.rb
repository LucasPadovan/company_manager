module ApplicationHelper
  def title
    [t('app_name'), @title].compact.join(' | ')
  end

  def show_menu_link(options = {})
    name = t("menu.#{options[:name]}")
    classes = []

    classes << 'active' if [*options[:controllers]].include?(controller_name)

    content_tag(
      :li, link_to(name, options[:path]),
      class: (classes.empty? ? nil : classes.join(' '))
    )
  end

  def show_button_dropdown(main_action, extra_actions = [], options = {})
    if extra_actions.blank?
      main_action
    else
      out = ''.html_safe
      
      out << render(
        partial: 'shared/button_dropdown', locals: {
          main_action: main_action, extra_actions: extra_actions
        }
      )
    end
  end
  
  def pagination_links(objects, params = nil)
    result = will_paginate objects,
      inner_window: 1, outer_window: 1, params: params,
      renderer: BootstrapPaginationHelper::LinkRenderer,
      class: 'pagination pagination-right'
    page_entries = content_tag(
      :blockquote,
      content_tag(
        :small,
        page_entries_info(objects),
        class: 'page-entries hidden-desktop pull-right'
      )
    )
    
    unless result
      previous_tag = content_tag(
        :li,
        content_tag(:a, t('will_paginate.previous_label').html_safe),
        class: 'previous_page disabled'
      )
      next_tag = content_tag(
        :li,
        content_tag(:a, t('will_paginate.next_label').html_safe),
        class: 'next disabled'
      )
      
      result = content_tag(
        :div,
        content_tag(:ul, previous_tag + next_tag),
        class: 'pagination pagination-right'
      )
    end

    result + page_entries
  end
  def current_section(paths)
    if paths.any? { |path| current_page?(path) }
      'current-section'
    end
  end

  def current_subsection(paths)
    if paths.any? { |path| current_page?(path) }
      'current-subsection'
    end
  end

  def link_to_show(*args)
    options = args.extract_options!

    options['class'] ||= 'iconic'
    options['title'] ||= t('label.show')
    options['data-show-tooltip'] ||= true

    link_to '&#xe074;'.html_safe, *args, options
  end

  def link_to_add(title, where_to)
    button_icon_text = content_tag(:div, '+', class: 'button-icon-text', style: ('padding-top: 5px' if /Firefox/.match request.env['HTTP_USER_AGENT']) )
    button_icon = content_tag(:div, button_icon_text, class: 'button-icon')
    button_text = content_tag(:div, link_to( title, where_to, class: 'btn btn-danger' ), class: 'button-text')
    content_tag(:div, button_icon + button_text, class: 'button-iconized')
  end

  def link_to_new(name, *args)
    options = args.extract_options!

    options['class'] ||= 'btn btn-primary stitched'
    options['title'] ||= t('label.new')
    options['data-show-tooltip'] ||= true

    link_to content_tag(:i, '', class: 'icon-plus-sign') + ' ' + name, *args, options
  end

  def link_to_edit(*args)
    options = args.extract_options!

    options['class'] ||= 'iconic'
    options['title'] ||= t('label.edit')
    options['data-show-tooltip'] ||= true

    link_to '&#x270e;'.html_safe, *args, options
  end

  def link_to_destroy(*args)
    options = args.extract_options!

    options['class'] ||= 'iconic'
    options['title'] ||= t('label.delete')
    options['method'] ||= :delete
    options['data-confirm'] ||= t('messages.confirmation')
    options['data-show-tooltip'] ||= true

    link_to '&#xe05a;'.html_safe, *args, options
  end

  def link_to_back(*args)
    options = args.extract_options!

    options['class'] ||= 'btn btn-inverse stitched'
    options['title'] ||= t('commmon.back')
    options['data-show-tooltip'] ||= true

    link_to t('commmon.back'), *args, options

  end

  def srbuj_link_to_new(name, *args)
    options = args.extract_options!

    options['class'] ||= 'btn btn-primary stitched'
    options['title'] ||= t('label.new')
    options['data-show-tooltip'] ||= true
    options['data-remote'] = true
    options['data-target'] ||= 'modal'
    options['data-modal'] ||= true
    link_to content_tag(:i, '', class: 'icon-plus-sign') + ' ' + name, *args, options
  end

  def srbuj_link_to_edit(*args)
    options = args.extract_options!

    options['class'] ||= 'iconic'
    options['title'] ||= t('label.edit')
    options['data-show-tooltip'] ||= true
    options['data-remote'] = true
    options['data-target'] ||= 'modal'
    options['data-modal'] ||= true

    link_to content_tag(:i, '', class: 'icon-pencil'), *args, options
  end

  def srbuj_link_to_show(*args)
    options = args.extract_options!

    options['class'] ||= 'iconic'
    options['title'] ||= t('label.show')
    options['data-show-tooltip'] ||= true
    options['data-remote'] = true
    options['data-target'] ||= 'modal'
    options['data-modal'] ||= true

    link_to content_tag(:i, '', class: 'icon-zoom-in'), *args, options
  end

  def srbuj_link_to_destroy(*args)
    options = args.extract_options!

    options['class'] ||= 'iconic'
    options['title'] ||= t('label.delete')
    options['method'] ||= :delete
    options['data-confirm'] ||= t('messages.confirmation')
    options['data-show-tooltip'] ||= true
    options['data-remote'] = true
    options['data-target'] ||= nil

    link_to content_tag(:i, '', class: 'icon-remove'), *args, options
  end

  def link_to_close_modal
    link_to_function 'Cerrar', "$('#modal').modal('toggle');", class: 'btn'
  end

  def link_to_csv(*args)
    name = args.shift
    link_to content_tag(:i, '', class: 'icon-share') + name, *args, class: 'btn btn-info'
  end
end
