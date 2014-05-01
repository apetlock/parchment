# Parchment

Parchment is a simple, flexible library for interacting with word processing
document files. Initially intended for outputting .docx and .odt files as
HTML fragments, it is built to be flexible for future use.

## Installation

Add this line to your application's Gemfile:

    gem 'parchment'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install parchment

## Usage

    require 'parchment'
    doc = Parchment.read('path/to/file.odt')
    doc.to_html

## Contributing

1. Fork it ( https://github.com/apetlock/parchment/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

### RSpec tests

I love TDD/BDD, but not to an insane level. Any tests written should test
input and output. Did the file get read properly? Is it outputting properly?
Internals do not need to be tested. For example, testing if a paragraph is
aligned_right? is necessary. Making sure that the class stores the alignment
as String 'right' is not.
