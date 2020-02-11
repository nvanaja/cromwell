task foo {
  command {
    touch foo
  }
  output {
    File foo = "foo"
  }
  runtime {
    docker: "ubuntu:latest"
  }
}

task bar {
  File foo
  command {
    gzip ${foo}
  }
  output {
    File bar = "${foo}.gz"
  }
  runtime {
    docker: "ubuntu:latest"
  }
}

task baz {
  File bar
  command {
    echo "Got ${bar}"
  }
  runtime {
    docker: "ubuntu:latest"
  }
}

workflow passing_files {
  call foo
  call bar { input: foo = foo.foo }
  call baz { input: bar = bar.bar }
}
