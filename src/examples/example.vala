
private int test_percent;
private ValUI.Meter meter_0;
private ValUI.Meter meter_1;
private ValUI.Meter meter_2;

public class Example : Gtk.Window {

    public Example () {
        set_default_size (400, 450);
        test_percent = 0;
        
        meter_0 = new ValUI.Meter (Gtk.Orientation.VERTICAL, 50, 75, true);
        meter_0.set_percent (65);

        meter_1 = new ValUI.Meter (Gtk.Orientation.HORIZONTAL, 0, 100);
        meter_1.set_percent (55);

        meter_2 = new ValUI.Meter (Gtk.Orientation.VERTICAL, 30, 120, true);
        meter_2.set_percent (85);
    }
}

public static int main (string[] args) {
    Gtk.init (ref args);

    var window = new Example ();

    // add custom ui

    var main_box = new Gtk.Box (Gtk.Orientation.VERTICAL, 6);
    
    var main_grid = new Gtk.Grid();
    main_grid.set_column_spacing (0);
    main_grid.set_row_spacing (0);
    main_grid.set_margin_top (0);
    main_grid.set_margin_bottom (0);
    main_grid.set_margin_start (0);
    main_grid.set_margin_end (0);
    main_grid.set_column_homogeneous (true);
    main_grid.set_row_homogeneous (true);

    var frame_meter0 = new Gtk.Frame ("Vertical");
    frame_meter0.add (meter_0);

    var frame_meter1 = new Gtk.Frame ("Horizontal");
    frame_meter1.add (meter_1);

    var plus_btn = new Gtk.Button ();
    plus_btn.set_label ("Plus 5 Percent");
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

    var frame_meter2 = new Gtk.Frame ("Vertical");
    meter_2.set_size (100, 150);
    frame_meter2.add (meter_2);
    frame_meter2.set_halign (Gtk.Align.CENTER);
    frame_meter2.set_valign (Gtk.Align.CENTER);

    main_box.pack_start (frame_meter2, true, true, 0);
    main_box.pack_start (main_grid, true, true, 0);

    window.add (main_box);

    window.destroy.connect (Gtk.main_quit);
    window.show_all ();
    window.present ();
    print  ( (window.get_allocated_width ()).to_string () + " x " + (window.get_allocated_height ()).to_string () + "\n");
    print  ( (frame_meter0.get_allocated_width ()).to_string () + " x " + (frame_meter0.get_allocated_height ()).to_string () + "\n");
    print  ( (frame_meter1.get_allocated_width ()).to_string () + " x " + (frame_meter1.get_allocated_height ()).to_string () + "\n");
    meter_0.fit_size (frame_meter0);
    meter_1.fit_size (frame_meter1);
    meter_2.fit_size (frame_meter2);

    Gtk.main ();
    return 0;
}

private void plus_percent () {
    test_percent = test_percent + 5;
    if (test_percent <= 100) {
        meter_0.set_percent (test_percent);
        meter_1.set_percent (test_percent);
        meter_2.set_percent (test_percent);
    }
}

private void reset_percent () {
    test_percent = 0;
    meter_0.set_percent (test_percent);
    meter_1.set_percent (test_percent);
    meter_2.set_percent (test_percent);
}