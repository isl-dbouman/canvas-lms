# frozen_string_literal: true

#
# Copyright (C) 2017 - present Instructure, Inc.
#
# This file is part of Canvas.
#
# Canvas is free software: you can redistribute it and/or modify it under
# the terms of the GNU Affero General Public License as published by the Free
# Software Foundation, version 3 of the License.
#
# Canvas is distributed in the hope that it will be useful, but WITHOUT ANY
# WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR
# A PARTICULAR PURPOSE. See the GNU Affero General Public License for more
# details.
#
# You should have received a copy of the GNU Affero General Public License along
# with this program. If not, see <http://www.gnu.org/licenses/>.
#

require_relative 'messages_helper'

describe 'peer_review_invitation' do
  include MessagesCommon

  before :once do
    assessment_request_model
  end

  let(:notification_name) { :peer_review_invitation }
  let(:asset) { @assessment_request }
  let(:anonymous_user) { 'Anonymous User' }

  context "anonymous peer disabled" do
    context ".email" do
      let(:path_type) { :email }

      it "renders" do
        message = generate_message(notification_name, path_type, asset)
        expect(message.body).not_to include(anonymous_user)
      end
    end

    context ".sms" do
      let(:path_type) { :sms }

      it "renders" do
        message = generate_message(notification_name, path_type, asset)
        expect(message.body).not_to include(anonymous_user)
      end
    end

    context ".summary" do
      let(:path_type) { :summary }

      it "renders" do
        message = generate_message(notification_name, path_type, asset)
        expect(message.body).not_to include(anonymous_user)
      end
    end

    context ".twitter" do
      let(:path_type) { :twitter }

      it "renders" do
        message = generate_message(notification_name, path_type, asset)
        expect(message.body).not_to include(anonymous_user)
      end
    end
  end

  context "anonymous peer enabled" do
    before :once do
      assignment = @assessment_request.asset.assignment
      assignment.update_attribute(:anonymous_peer_reviews, true)
      @assessment_request.reload
    end

    context ".email" do
      let(:path_type) { :email }

      it 'shows anonymous when anonymous peer review enabled' do
        message = generate_message(notification_name, path_type, asset)
        expect(message.body).to include(anonymous_user)
      end
    end

    context ".sms" do
      let(:path_type) { :sms }

      it 'shows anonymous when anonymous peer review enabled' do
        message = generate_message(notification_name, path_type, asset)
        expect(message.body).to include(anonymous_user)
      end
    end

    context ".summary" do
      let(:path_type) { :summary }

      it 'shows anonymous when anonymous peer review enabled' do
        message = generate_message(notification_name, path_type, asset)
        expect(message.body).to include(anonymous_user)
      end
    end

    context ".twitter" do
      let(:path_type) { :twitter }

      it 'shows anonymous when anonymous peer review enabled' do
        message = generate_message(notification_name, path_type, asset)
        expect(message.body).to include(anonymous_user)
      end
    end
  end
end
