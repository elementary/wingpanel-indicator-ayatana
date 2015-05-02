// -*- Mode: vala; indent-tabs-mode: nil; tab-width: 4 -*-
//  
//  Copyright (C) 2011-2012 Wingpanel Developers
// 
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
// 
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
// 
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

public class AyanataCompatibility.IndicatorButton : Gtk.Box {
    public enum WidgetSlot {
        LABEL,
        IMAGE
    }

    private Gtk.Widget the_label;
    private Gtk.Widget the_image;

    public IndicatorButton () {
        set_orientation (Gtk.Orientation.HORIZONTAL);
        set_homogeneous (false);

        get_style_context ().add_class ("composited-indicator");
    }

    public void set_widget (WidgetSlot slot, Gtk.Widget widget) {
        Gtk.Widget old_widget = null;

        if (slot == WidgetSlot.LABEL)
            old_widget = the_label;
        else if (slot == WidgetSlot.IMAGE)
            old_widget = the_image;

        if (old_widget != null) {
            remove (old_widget);
            old_widget.get_style_context ().remove_class ("composited-indicator");
        }

        // Workaround for buggy indicators: Some widgets may still be part of a previous entry
        // if their old parent hasn't been removed from the panel yet.
        var parent = widget.parent;
        if (parent != null)
            parent.remove (widget);

        widget.get_style_context ().add_class ("composited-indicator");

        if (slot == WidgetSlot.LABEL) {
            the_label = widget;
            pack_end (the_label, false, false, 0);
        } else if (slot == WidgetSlot.IMAGE) {
            the_image = widget;
            pack_start (the_image, false, false, 0);
        } 
    }
}
