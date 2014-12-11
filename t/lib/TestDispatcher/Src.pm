package TestDispatcher::Src;
use Amon2::Web::Dispatcher::RouterBoom;
use Route::Switcher;

Route::Switcher->methods(qw/get post any delete_/);


switcher {
    base '/user_account' => 'Hoge::UserAccount';

    get('/new'  => '#new');
    post('/new'  => '#new');
    get('/edit' => '#edit');
    any('/edit' => '#edit');
};

switcher {
    base '/post/' => 'Hoge::Post';

    get('new'  => '#new');
    post('new'  => '#new');
    get('edit' => '#edit');
    delete_('delete' => '#delete');
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
any('/no_base'  => 'NoBase#new');
delete_('/no_base'  => 'NoBase#new');

1;
