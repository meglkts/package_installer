require_relative '../package_installer'

describe 'package_installer' do
	let(:valid_set1) { ['KittenService: CamelCaser', 'CamelCaser: '] }
	let(:valid_set2) { ['KittenService: ','Leetmeme: Cyberportal','Cyberportal: Ice','CamelCaser: KittenService','Fraudstream: Leetmeme','Ice: '] }
	let(:valid_set3) { ['KittenService: Leetmeme', 'CamelCaser: Leetmeme', 'Leetmeme: ', 'Fraudstream: Cyberportal', 'Ice: ', 'Cyberportal: Ice']}
	let(:invalid_set) { ['KittenService: ','Leetmeme: Cyberportal','Cyberportal: Ice','CamelCaser: KittenService','Fraudstream: ','Ice: Leetmeme'] }


	describe '#format_array' do
		it 'should return an array containing packages and dependencies as inner arrays' do
			expect(format_input(valid_set1)).to eq([['KittenService', 'CamelCaser'], ['CamelCaser']])
		end
	end

	describe '#find_dependencies' do
		it 'should return a hash containing packages and dependencies as key value pairs' do
			dependencies = find_dependencies(valid_set1)
			expect(dependencies['KittenService']).to eq('CamelCaser')
		end
	end

	describe '#independent_packages' do
		it 'should add packages with no dependencies to the ordered installation array' do
			expect(independent_packages(valid_set2)).to eq(['KittenService', 'Ice'])
		end
	end

	describe '#order_packages for valid input' do
		it 'should order packages so dependencies precede their dependent packages' do
			expect(order_packages(valid_set1)).to eq(['CamelCaser', 'KittenService'])
		end
	end

	describe '#order_packages for valid input' do
		it 'should return array with all original packages included' do
			expect(order_packages(valid_set2).count).to eq(6)
		end
	end

	describe '#order_packages for valid input' do
		it 'should order packages so dependencies precede their dependent packages' do
			installation_array = order_packages(valid_set2)
			expect(installation_array.index('Fraudstream')).to be > installation_array.index('Leetmeme')
			expect(installation_array.index('Leetmeme')).to be > installation_array.index('Cyberportal')
		end
	end

	# describe '#order_packages for valid input' do
	# 	it 'should order packages so dependencies precede their dependent packages' do
	# 		installation_array = order_packages(valid_set3)
	# 		expect(installation_array.index('Leetmeme')).to be > installation_array.index('Cyberportal')
	# 	end
	# end

	10.times do
		describe '#order_packages for valid input' do
			it 'should order packages so dependencies precede their dependent packages' do
				input = valid_set2.shuffle
				installation_array = order_packages(input)
				expect(installation_array.index('Cyberportal')).to be > installation_array.index('Ice')
				expect(installation_array.index('Leetmeme')).to be > installation_array.index('Cyberportal')
				expect(installation_array.index('Fraudstream')).to be > installation_array.index('Leetmeme')
			end
		end
	end

	5.times do
		describe '#order_packages for invalid input' do
			it 'should throw exception for cyclical package dependency' do
				expect { order_packages(invalid_set.shuffle) }.to raise_error("Package set contains cycle")
			end
		end
	end

	describe '#installation_order_to_s for valid input' do
		it 'should take the input array and return as a string' do
			expect(installation_order_to_s(valid_set1)).to eq('CamelCaser, KittenService')
		end
	end

	describe '#installation_order_to_s for invalid input' do
		it 'should take the input array and return as a string' do
			expect { installation_order_to_s(invalid_set) }.to raise_error("Package set contains cycle")
		end
	end
end



