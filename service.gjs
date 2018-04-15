#!/usr/bin/env gjs
const Gio = imports.gi.Gio; 
const Gtk = imports.gi.Gtk;

Gtk.init(null);
Gtk.Settings.get_default().set_property('gtk-application-prefer-dark-theme', true);
Gtk.Settings.get_default().gtk_theme_name = "Adwaita";

var window = new Gtk.Window();
window.set_title("Servicios");
window.connect("destroy", Gtk.main_quit);
window.set_border_width(15);

var grid = new Gtk.Grid();
grid.set_row_spacing(10);
grid.set_column_spacing(10);
grid.set_row_homogeneous(true);
grid.set_column_homogeneous(true);
window.add(grid);

//MYSQL
var label_mysql = new Gtk.Label({label: "Mysql server"});
var switch_mysql = new Gtk.Switch();
switch_mysql.id = 1;
switch_mysql.connect("notify::active", function() {on_switch_toggled(switch_mysql)});

grid.attach(label_mysql, 0, 0, 1, 1);
grid.attach(switch_mysql, 1, 0, 1, 1);


//PHP
var label_php = new Gtk.Label({label: "PHP server"});
var switch_php = new Gtk.Switch();
switch_php.id = 2;
switch_php.connect("notify::active", function() {on_switch_toggled(switch_php)});

grid.attach(label_php, 0, 1, 1, 1);
grid.attach(switch_php, 1, 1, 1, 1);

//NGINX
var label_nginx = new Gtk.Label({label: "Nginx server"});
var switch_nginx = new Gtk.Switch();
switch_nginx.id = 3;
switch_nginx.connect("notify::active", function() {on_switch_toggled(switch_nginx)});

grid.attach(label_nginx, 0, 2, 1, 1);
grid.attach(switch_nginx, 1, 2, 1, 1);


//BOTONES DE ESTADOS
var start_service = new Gtk.Button({label: 'Iniciar todos'});
start_service.connect('clicked', function (argument) {

    let subprocess = new Gio.Subprocess({ 
        argv: ['/bin/ls'], 
        flags: Gio.SubprocessFlags.STDOUT_PIPE, 
    }); 
    subprocess.init(null); 
    let [, out] = subprocess.communicate_utf8(null, null); 
    print(out);

});
var stop_service = new Gtk.Button({label: 'Detener todos'});
stop_service.connect('clicked', function (argument) {
    print("todos los servicios")
});

grid.attach(start_service, 0, 3, 1, 1);
grid.attach(stop_service, 1, 3, 1, 1);


window.show_all();

Gtk.main();


function on_switch_toggled(gtkswitch){
    if (gtkswitch.get_active())
    {
        print("Switch " + gtkswitch.id + " - on");
    }
    else
    {
        print("Switch " + gtkswitch.id + " - off");
    }
}