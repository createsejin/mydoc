use std::{thread, time::Duration};

use ime_checker::get_ime_mode;

fn main() {
  loop {
    let result = get_ime_mode();
    println!("result = {result}");

    thread::sleep(Duration::from_millis(1000));
  }
}
