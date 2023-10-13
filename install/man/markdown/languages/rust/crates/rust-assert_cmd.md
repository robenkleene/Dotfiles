# `assert_cmd`

To get the output of a test, with:

```
        let output = mov()
            .current_dir(tmp_dir_path)
            .write_stdin(input)
            .args(&["change", "altered", "-w"])
            .assert()
            .success().get_output();
```

To get both `STDIN` and `STDOUT` of a test:

```
        let command = mov()
            .current_dir(tmp_dir_path)
            .write_stdin(input)
            .args(&["change", "altered", "-w"])
            .assert()
            .success();
        let output = command.get_output();
        println!("stdout = {:?}", String::from_utf8_lossy(&output.stdout));
        println!("stderr = {:?}", String::from_utf8_lossy(&output.stderr));
```
