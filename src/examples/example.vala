namespace ValUI {

    private double test_percent;
    private ValUI.Meter meter_0;
    private ValUI.Meter meter_1;

    public class Example : Gtk.Window {

        public Example () {
            set_default_size (400, 450);
            test_percent = 0;
        }
    }

    public static int main (string[] args) {
        Gtk.init (ref args);

        var window = new Example ();

        // add custom ui

        var main_grid = new Gtk.Grid();
        main_grid.set_column_spacing (0);
        main_grid.set_row_spacing (0);
        main_grid.set_margin_top (0);
        main_grid.set_margin_bottom (0);
        main_grid.set_margin_start (0);
        main_grid.set_margin_end (0);
        main_grid.set_column_homogeneous (true);
        main_grid.set_row_homogeneous (true);

        meter_0 = new ValUI.Meter (Gtk.Orientation.VERTICAL, 100, 100);
        meter_0.set_percent (65.4);
        var frame_meter0 = new Gtk.Frame ("Vertical");
        frame_meter0.add (meter_0);
        // meter_0.set_size_request (frame_meter0.get_allocated_width (), frame_meter0.get_allocated_height ());

        meter_1 = new ValUI.Meter (Gtk.Orientation.HORIZONTAL, 100, 100);
        meter_1.set_percent (43.4);
        var frame_meter1 = new Gtk.Frame ("Horizontal");
        frame_meter1.add (meter_1);
        // meter_1.set_size_request (frame_meter1.get_allocated_width (), frame_meter1.get_allocated_height ());

        var plus_btn = new Gtk.Button ();
        plus_btn.set_label ("Plus 10 Percent");
        plus_btn.clicked.connect (plus_percent);

        var reset_btn = new Gtk.Button ();
        reset_btn.set_label ("Reset Percent");
        reset_btn.clicked.connect (reset_percent);

        main_grid.attach (frame_meter0, 0, 0, 1, 1);
        main_grid.attach (frame_meter1, 1, 0, 1, 1);
        main_grid.attach (plus_btn, 0, 1, 1, 1);
        main_grid.attach (reset_btn, 1, 1, 1, 1);
        main_grid.set_hexpand (true);
        main_grid.set_vexpand (true);

        window.add (main_grid);

        window.destroy.connect (Gtk.main_quit);
        window.show_all ();
        window.show ();
        window.present ();
        print  ( (window.get_allocated_width ()).to_string () + " x " + (window.get_allocated_height ()).to_string () + "\n");
        print  ( (frame_meter0.get_allocated_width ()).to_string () + " x " + (frame_meter0.get_allocated_height ()).to_string () + "\n");
        print  ( (frame_meter1.get_allocated_width ()).to_string () + " x " + (frame_meter1.get_allocated_height ()).to_string () + "\n");
        meter_0.fit_size (frame_meter0);
        meter_1.fit_size (frame_meter1);

        Gtk.main ();
        return 0;
    }

    private void plus_percent () {
        test_percent = test_percent + 10;
        if (test_percent <= 100) {
            meter_0.set_percent (test_percent);
            meter_1.set_percent (test_percent);
        }
    }

    private void reset_percent () {
        test_percent = 0;
        meter_0.set_percent (test_percent);
        meter_1.set_percent (test_percent);
    }
}