# NAME

Route::Switcher - It's new $module

# SYNOPSIS

    package TestDispatcher;
    use Hoge::Dispatcher; #export get,post method
    use Route::Switcher;

    # redefine get,post method
    Route::Switcher->methods(qw/get post/);

    switcher {
        base '/user_account' => 'Hoge::UserAccount';

        get('/new'  => '#new');
        post('/new'  => '#new');
        get('/edit' => '#edit');
    };

    switcher {
        base '/post/' => 'Hoge::Post';

        get('new'  => '#new');
        post('new'  => '#new');
        get('edit' => '#edit');
    };

    switcher {

        base '/a/' => 'Hoge::A';
        get('new'  => '#new');

        base '/b/' => 'Hoge::B';
        get('new'  => '#new');

        base '' => '';
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
