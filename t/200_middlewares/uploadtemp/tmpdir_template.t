use t::200_middlewares::uploadtemp::base;
use Test::More tests => 5;

my $base_tmp   = quotemeta(File::Spec->tmpdir);
my $upload_tmpdir;
do {
    my $he = new_engine {
        my $req = shift;
        $upload_tmpdir = $req->request_builder->upload_tmp;
        if ($req->method eq 'POST') {
            ok(-f $req->upload('upfile')->tempname, 'upload file');
        }
    } {
        tmpdir   => 1,
        template => 'TESTTMPDIR_XXXX',
    };
    $he->run(
        POST 'http://example.com/',
        Content_Type => 'form-data',
        Content      => [
            upfile => ['README'],
        ],
    );
    like($upload_tmpdir, qr{\A$base_tmp}, 'base tmpdir');
    like($upload_tmpdir, qr{TESTTMPDIR_}, 'use template');
    ok(-d $upload_tmpdir, 'alive tmpdir');
};
ok(rmtree($upload_tmpdir, 0), 'rmtree');
