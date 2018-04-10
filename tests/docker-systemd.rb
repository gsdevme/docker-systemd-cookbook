describe service('docker') do
  it { should be_installed }
  it { should be_running }
end

describe service('redis') do
  it { should be_installed }
  it { should be_running }
end

describe '8888 pong' do
  it 'redis is listening on 8888 and ping/pong works' do
    expect(command('echo "ping" | ncat 127.0.0.1 8888 | grep PONG').exit_status).to eq(0)
  end
end
