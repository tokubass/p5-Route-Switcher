package Route::Switcher;
use 5.008001;
use strict;
use warnings;
use base 'Exporter';
our $VERSION = "0.01";

our @EXPORT = qw/switcher/;

my $CALLER = caller;
my @methods;
my %ORIG_METHOD;
our ($base_path,$base_class);

sub init {
    my $class = shift;
    my @methods  = @_;
    $class->methods(@_);

    no strict 'refs';
    no warnings 'redefine';
    for my $method (@methods) {
        *{"$CALLER\::$method"} = sub  {
            my $path = ($base_path  || '') . $_[0];
            my $dest = ($base_class || '') . $_[1];
            $ORIG_METHOD{$method}->($path,$dest);
        };
    }
}

sub switcher {
    local $base_path = shift;
    local $base_class = shift;
    my $code = shift;
    $code->();
}

sub methods {
    my $class = shift;
    if (@_) {
        @methods = @_;
        _cache_original_method();
    }
    return @methods;
}


sub _cache_original_method {
    for my $method (@methods) {
        next unless( my $sub = $CALLER->can($method));
        $ORIG_METHOD{$method} = $sub;
    }
}

1;

__END__

=encoding utf-8

=head1 NAME

Route::Switcher - It's new $module

=head1 SYNOPSIS

    package TestDispatcher;
    use Hoge::Dispatcher; #export get,post method
    use Route::Switcher;

    # redefine get,post method
    Route::Switcher->init(qw/get post/);

    switcher '/user_account' => 'Hoge::UserAccount', sub {
        get('/new'  => '#new');
        post('/new'  => '#new');
        get('/edit' => '#edit');
    };

    switcher '/post/' => 'Hoge::Post', sub {
        get('new'  => '#new');
        post('new'  => '#new');
        get('edit' => '#edit');
    };

    switcher '' => '', sub {
        get('new'  => 'NoBase#new');
    };

    get('/no_base'  => 'NoBase#new');
    post('/no_base'  => 'NoBase#new');


=head1 DESCRIPTION

Route::Switcher is ...

=head1 LICENSE

Copyright (C) tokubass.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

tokubass E<lt>tokubass@cpan.orgE<gt>

=cut

