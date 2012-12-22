# coding: utf-8
require 'spec_helper'

describe Authentication do
  include RSpec::Rails::ControllerExampleGroup

  controller do
    include Authentication
    def index
      @current_user = current_user
      render :nothing => true
    end
  end

  describe '#current_user' do
    let(:you) { FactoryGirl.create(:user) }

    before do
      User.stub(:find) { you }
      get :index
    end

    it { assigns(:_current_user).should eq you }
  end
end
