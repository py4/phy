Exam.destroy_all
Dir.foreach('config/exams') do |item|
	next if item == '.' or item == '..'

	lines = File.readlines('config/exams/'+item)
	exam = Exam.create! name: lines[0].strip, subject: {}
	step = lines[1].strip.to_i
	i = 2
	question_index = 0
	while i < lines.size
		step = 3 if(question_index == 12 and item == 'phyisc')
		question_content = lines[i]
		question = exam.questions.create! content: question_content.strip
		lines[i+1..i+step].each { |choice| question.choices.create content: choice.strip }
		break if i+step+1 >= lines.size
		s = "" ; lines[i+step+1..i+2*step].each { |char| s += char.strip }
		question.update_attributes! mask: s
		i += 2*step + 1
		question_index += 1
	end
end

Dir.foreach('config/subjects') do |item|
	next if item == '.' or item == '..'

	lines = File.readlines('config/subjects/'+item)
	exam = Exam.find_by(name: lines[0].strip)
	subject = {}
	lines[1..-1].each do |line|
		words = line.split('-')
		subject[words[0]] = words[1].split(',').map { |w| w.to_i }
	end
	exam.update_attributes subject: subject
	puts "exam after save: #{exam.subject}"
end

Task.destroy_all

TASKS = ['اضافه کردن کد کاربری داوطلب',
	'فعال کردن فرم اطلاعات اولیه شامل مصاحبه و فیزیک',
	'پر شدن فرم اطلاعات اولیه توسط داوطلب',
	'فعال کردن موردی آزمون‌های شناختی',
	'پرشدن آزمون‌های شناختی توسط داوطلب',
	'فعال کردن موردی آزمون‌های عاطلب و هیجانی',
	'پرشدن آزمون‌های عاطفی و هیجانی توسط داوطلب'
]

TASKS.each do |task|
	Task.create title: task
end
