# == Schema Information
# Schema version: 95
#
# Table name: contact_validators
#
#  name    :string
#  email   :string
#  subject :text
#  message :text
#

# models/contact_validator.rb:
# Validates contact form submissions.
#
# Copyright (c) 2008 UK Citizens Online Democracy. All rights reserved.
# Email: francis@mysociety.org; WWW: http://www.mysociety.org/
#
# $Id: contact_validator.rb,v 1.32 2009-09-17 21:10:05 francis Exp $

class ContactValidator < ActiveRecord::BaseWithoutTable
    strip_attributes!

    column :name, :string
    column :email, :string
    column :subject, :text
    column :message, :text

    validates_presence_of :name, :message => N_("Please enter your name")
    validates_presence_of :email, :message => N_("Please enter your email address")
    validates_presence_of :subject, :message => N_("Please enter a subject")
    validates_presence_of :message, :message => N_("Please enter the message you want to send")

    def validate
        errors.add(:email, "Email doesn't look like a valid address") unless MySociety::Validate.is_valid_email(self.email)
    end

end
