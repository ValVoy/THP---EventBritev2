# frozen_string_literal: true

require 'pagy/classes/request'
require 'pagy/toolbox/paginators/offset'

# Configuration par défaut
Pagy::OPTIONS[:limit] = 9

Pagy::OPTIONS.freeze