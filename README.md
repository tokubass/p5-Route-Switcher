# NAME

Route::Switcher - It's new $module

# SYNOPSIS

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

# DESCRIPTION

Route::Switcher is ...

# LICENSE

Copyright (C) tokubass.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

# AUTHOR

tokubass <tokubass@cpan.org>
