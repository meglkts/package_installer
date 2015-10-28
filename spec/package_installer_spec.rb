require_relative '../package_installer'

describe 'package_installer' do
	let(:packages1) { ['KittenService: CamelCaser', 'CamelCaser: '] }
	let(:packages2) { ['KittenService: ','Leetmeme: Cyberportal','Cyberportal: Ice','CamelCaser: KittenService','Fraudstream: Leetmeme','Ice: '] }


	describe '#format_array' do
		it 'should return an array containing packages and dependencies as inner arrays' do
			expect(format_input(packages1)).to eq([['KittenService', 'CamelCaser'], ['CamelCaser']])
		end
	end

	describe '#add_no_dependencies' do
		it 'should add packages with no dependencies to the ordered installation array' do
			formatted_array = format_input(packages2)
			expect(no_dependency_packages(formatted_array)).to eq(['KittenService', 'Ice'])
		end
	end

	describe '#order_packages' do
		it 'should order packages so dependencies precede their dependent packages' do
			expect(order_packages(packages1)).to eq(['CamelCaser', 'KittenService'])
		end
	end

	describe '#installation_order' do
		it 'should take the ordered array and return as a string' do
			expect(installation_order(packages1)).to eq('CamelCaser, KittenService')
		end
	end
end

