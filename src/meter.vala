/*
 * meter.vala
 * 
 * Copyright 2021 Nicola tudino <nicola.tudino@gmail.com>
 * 
 * This file is part of ValUI.
 *
 * ValUI is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3 of the License.
 *
 * ValUI is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with ValUI.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-only
 */


namespace ValUI {
    
    /**
     * 
     */
    public class Meter : Gtk.DrawingArea {

        private double percent;
        private bool vertical;
        private int my_width;
        private int my_height;
        private bool my_debug;
        
        public Meter (Gtk.Orientation orientation, int width, int height, bool scale_on_resize = false, bool debug = false) {
            percent = 0;
            my_debug = debug;

            if (orientation == Gtk.Orientation.VERTICAL) {
                vertical = true;
            } else {
                vertical = false;
            }

            set_size_request (width, height);

            my_width = width;
            my_height = height;
            if (my_debug)
                print("start size: " + (my_width).to_string () + " x " + (my_height).to_string () + "\n");

            redraw_canvas ();
            if (scale_on_resize)
                this.configure_event.connect (on_window_configure_event);

            get_preferred_width (out width, out my_width);
        }

        public override bool draw (Cairo.Context cr) {
            var x0_rect1 = (double) ((double) my_width / 100) * 4.5;
            var x0_rect2 = (double) ((double) my_width / 100) * 52.5;
            var w_rect = (double) ((double) my_width / 100) * 43;
            var h_rect = (double) ((double) my_height / 100) * 3.5;
            var y0_rect = (double) ((double) my_height / 100) * 4.5;

            if (!vertical) {
                x0_rect1 = (double) ((double) my_height / 100) * 4.5;
                x0_rect2 = (double) ((double) my_height / 100) * 52.5;
                w_rect = (double) ((double) my_height / 100) * 43;
                h_rect = (double) ((double) my_width / 100) * 3.5;
                y0_rect = (double) ((double) my_width / 100) * 4.5;
            }

            var limit = (int) (20 - percent / 5);

            cr.save ();

            if (vertical) {
                /*
                 * Vertical
                 * start form top left corner to draw so rgb scale must start from red 
                 * for i = 1 and go green for i = 20
                 */
                for (int i = 1; i <= 20; i++) {
                    if (i > limit) {
                        cr.set_source_rgb (1.0 - (0.6 / 20) * i, 0.0 + (1.0 / 20) * i, 0);
                    } else {
                        cr.set_source_rgb (0.2, 0.4, 0);
                    }
                    cr.rectangle (x0_rect1, i * y0_rect, w_rect, h_rect);
                    cr.rectangle (x0_rect2, i * y0_rect, w_rect, h_rect);
                    if (my_debug)
                        print (
                            (x0_rect1).to_string () + " x " + (i * y0_rect).to_string () + " x " + (w_rect).to_string () + " x " + (h_rect).to_string () + " \n" +
                            (x0_rect2).to_string () + " x " + (i * y0_rect).to_string () + " x " + (w_rect).to_string () + " x " + (h_rect).to_string () + " \n"
                        );
                    cr.fill ();
                }
            } else {
                limit = (int) (percent / 5);
                /* 
                 *Horizontal
                 * start form top left corner to draw so rgb scale must start from green 
                 * for i = 1 and go red for i = 20
                 */
                for (int i = 1; i <= 20; i++) {
                    if (i <= limit) {
                        cr.set_source_rgb (0.4 + (0.6 / 20) * i, 1.0 - (1.0 / 20) * i, 0);
                    } else {
                        cr.set_source_rgb (0.2, 0.4, 0);
                    }
                    cr.rectangle (i * y0_rect, x0_rect1, h_rect, w_rect);
                    cr.rectangle (i * y0_rect, x0_rect2, h_rect, w_rect);
                    if (my_debug)
                        print (
                            (i * y0_rect).to_string () + " x " + (x0_rect1).to_string () + " x " + (h_rect).to_string () + " x " + (w_rect).to_string () + " \n" +
                            (i * y0_rect).to_string () + " x " + (x0_rect2).to_string () + " x " + (h_rect).to_string () + " x " + (w_rect).to_string () + " \n"
                        );
                    cr.fill ();
                }
            }
             if (my_debug) {
                // DEBUG TODO draw bordercontext.set_source_rgba (1, 0, 0, 1);
                cr.set_source_rgb (0, 0, 1);
                cr.set_line_width (1);

                cr.move_to (1, 1);
                cr.line_to (1, my_height - 1);
                cr.line_to (my_width - 1, my_height - 1);
                cr.line_to (my_width - 1, 1);
                cr.line_to (1, 1);

                print ("size after redraw:" + (my_width).to_string () + " x " + (my_height).to_string () + " \n");
             }
            
            cr.stroke ();
            cr.restore ();

            return false;
        }

        public bool fit_size (Gtk.Widget parent) {
            my_width = parent.get_allocated_width ();
            my_height = parent.get_allocated_height ();
            set_size_request (my_width, my_height);
            redraw_canvas ();
            return false;
        }

        private bool on_window_configure_event (Gtk.Widget sender, Gdk.EventConfigure event) {
            my_width = event.width;
            my_height = event.height;
            redraw_canvas ();
            return true;
        }

        private void redraw_canvas () {
            var window = get_window ();
            if (null == window) {
                return;
            }

            var region = window.get_clip_region ();
            // redraw the cairo canvas completely by exposing it
            window.invalidate_region (region, true);
            // window.process_updates (true);
        }

        public void set_percent (double sel) {
            percent = sel;
            redraw_canvas ();
        }
    }
}