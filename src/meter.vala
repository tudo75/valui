

namespace ValUI {
    
    /**
     * 
     */
    public class Meter : Gtk.DrawingArea {

        private double percent;
        private bool vertical;
        private int my_width;
        private int my_height;
        
        public Meter (Gtk.Orientation orientation, int width, int height) {
            percent = 0;
            if (orientation == Gtk.Orientation.VERTICAL) {
                vertical = true;
            } else {
                vertical = false;
            }

            set_size_request (width, height);

            my_width = width;
            my_height = height;
            
            redraw_canvas ();
        }

        public override bool draw (Cairo.Context cr) {
            /*
            var x = get_allocated_width () / 2;
            var y = get_allocated_height () / 2;
            var radius = double.min (get_allocated_width () / 2,
                                     get_allocated_height () / 2) - 5;
            cr.arc (x, y, radius, 0, 2 * Math.PI);
            cr.set_source_rgb (1, 1, 1);
            */

            var x0_rect1 = (int) (my_width / 100) * 5;
            var x0_rect2 = (int) (my_width / 100) * 53;
            var w_rect = (int) (my_width / 100) * 42;
            var h_rect = (int) (my_height / 100) * 4;
            var y0_rect = (int) (my_height / 100) * 5;

            if (!vertical) {
                x0_rect1 = (int) (my_height / 100) * 5;
                x0_rect2 = (int) (my_height / 100) * 53;
                w_rect = (int) (my_height / 100) * 42;
                h_rect = (int) (my_width / 100) * 4;
                y0_rect = (int) (my_width / 100) * 5;
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
                    cr.fill ();
                }
            }
            cr.stroke ();
            cr.restore ();

            return false;
        }

        public bool fit_size (Gtk.Widget parent) {
            my_width = parent.get_allocated_width ();
            my_height = parent.get_allocated_height ();
            redraw_canvas ();
            return false;
        }

        private void redraw_canvas () {
            var window = get_window ();
            if (null == window) {
                return;
            }

            var region = window.get_clip_region ();
            // redraw the cairo canvas completely by exposing it
            window.invalidate_region (region, true);
            window.process_updates (true);
        }

        public void set_percent (double sel) {
            percent = sel;
            redraw_canvas ();
        }
    }
}