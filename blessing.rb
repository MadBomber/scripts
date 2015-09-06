#!/usr/bin/env ruby
######################################################
###
##  File: blessing.rb
##  Desc: Say a blessing
#

require 'os'

blessings_text = <<EOS
You are blessed because you were uniquely handmade by the king of kings. (Psalm 139:14, "I will praise thee; for You are fearfully and wonderfully made: marvellous are thy works; and that my soul knoweth right well.")

You are loved so much that God sent His son to die as a symbol of His great love for you. (1 John 4:9, "In this was manifested the love of God toward us, because that God sent his only begotten Son into the world, that we might live through him.")

You are loved so much, that a big party was thrown in heaven when you were adopted into the royal family. (Luke 15:10, "Likewise, I say unto you, there is joy in the presence of the angels of God over one sinner that repenteth.")

Your past has been washed away, and you have been given a completely new identity through Christ. (2 Corinthians 5:17, "Therefore if any man be in Christ, he is a new creature: old things are passed away; behold, all things are become new.")

Your heavenly Father loves you so much, that He wanted you to be His child. (1 John 3:1, "Behold, what manner of love the Father hath bestowed upon us, that we should be called the sons of God...")

You are blessed because your shepherd loves you so much that He laid down His life for you. (John 10:11, 15:13, "You are the good shepherd: the good shepherd giveth his life for the sheep... Greater love hath no man than this, that a man lay down his life for his friends.")

You are blessed because there is no condemnation awaiting you. (Romans 8:1, "There is therefore now no condemnation to them which are in Christ Jesus...")

You are blessed because your sins are not only forgiven, but God Himself chose to forget them. (Isaiah 43:25, "I, even I, am he that blotteth out thy transgressions for mine own sake, and will not remember thy sins.")

You are blessed because God thinks wonderful things towards you. (Psalm 139:17, "How precious also are thy thoughts unto me, O God! how great is the sum of them!")

You are blessed to be loved with a love so deep, that nothing can separate you from it. (Romans 8:38-39, "For You are persuaded, that neither death, nor life, nor angels, nor principalities, nor powers, nor things present, nor things to come, Nor height, nor depth, nor any other creature, shall be able to separate us from the love of God, which is in Christ Jesus our Lord.")

You are loved for who you are, not because you are sinless or perfect. (Romans 5:8, "But God showed his great love for us by sending Christ to die for us while we were still sinners." (NLT), and Eph 2:4-7, "But God, who is rich in mercy, for his great love wherewith he loved us, Even when we were dead in sins, hath quickened us together with Christ, (by grace ye are saved;) And hath raised us up together, and made us sit together in heavenly places in Christ Jesus: That in the ages to come he might shew the exceeding riches of his grace in his kindness toward us through Christ Jesus.")

You are blessed to no longer be in the dark, but in the light. (Ephesians 5:8, "For ye were sometimes darkness, but now are ye light in the Lord: walk as children of light:")

You are so special to your heavenly father that He rejoices over you with great joy. (Isaiah 62:5, "For as a young man marrieth a virgin, so shall thy sons marry thee: and as the bridegroom rejoiceth over the bride, so shall thy God rejoice over thee.")

You are blessed because you have been given authority over devils, and you can cast them out through Jesus\' name. You can also heal the sick, because of the authority Jesus invested in you. (Luke 9:1, "Then he called his twelve disciples together, and gave them power and authority over all devils, and to cure diseases.", Mark 13:34, "For the Son of man is as a man taking a far journey, who left his house, and gave authority to his servants, and to every man his work, and commanded the porter to watch.", Mark 16:17-18, "And these signs shall follow them that believe; In my name shall they cast out devils; they shall speak with new tongues; They shall take up serpents; and if they drink any deadly thing, it shall not hurt them; they shall lay hands on the sick, and they shall recover." and Acts 3:6, "...Peter said, Silver and gold have I none; but such as I have give I thee: In the name of Jesus Christ of Nazareth rise up and walk.")

You are so blessed to be protected from all harm that comes your way. (Luke 10:17-19, "And the seventy returned again with joy, saying, Lord, even the devils are subject unto us through thy name. And he said unto them, I beheld Satan as lightning fall from heaven. Behold, I give unto you power to tread on serpents and scorpions, and over all the power of the enemy: and nothing shall by any means hurt you." and Mark 16:17-18, "And these signs shall follow them that believe... They shall take up serpents; and if they drink any deadly thing, it shall not hurt them...")

You are extremely blessed to not only be able to do the works Jesus did, but even greater. (John 14:12, "Verily, verily, I say unto you, He that believeth on me, the works that I do shall he do also; and greater works than these shall he do; because I go unto my Father.")

You are loved so much that the Father hath sent His Holy Spirit to live within you. (Galatians 4:5-6, "To redeem them that were under the law, that we might receive the adoption of sons. And because ye are sons, God hath sent forth the Spirit of his Son into your hearts, crying, Abba, Father.")

You are so special to your heavenly Father, that He wants to empower you with the same Holy Spirit that Jesus was anointed with for His own ministry. (Matthew 3:11, "I indeed baptize you with water unto repentance: but he that cometh after me is mightier than I, whose shoes You are not worthy to bear: he shall baptize you with the Holy Ghost, and with fire:" and Acts 1:8, "But ye shall receive power, after that the Holy Ghost is come upon you...")

You are entitled to complete physical healing and deliverance from evil spirits through the work Christ did on the cross for you. (Isaiah 53:5, "But he was wounded for our transgressions, he was bruised for our iniquities: the chastisement of our peace was upon him; and with his stripes we are healed." and Matthew 8:16-17, "When the even was come, they brought unto him many that were possessed with devils: and he cast out the spirits with his word, and healed all that were sick: That it might be fulfilled which was spoken by Isaiah the prophet, saying, Himself took our infirmities, and bare our sicknesses.")

You were not given a spirit of fear, but of love and a sound mind. (2 Timothy 1:7, "For God hath not given us the spirit of fear; but of power, and of love, and of a sound mind." and Romans 8:15, "For ye have not received the spirit of bondage again to fear; but ye have received the Spirit of adoption, whereby we cry, Abba, Father.")

Your heavenly Father loves you so much, that there is no sin that you could take to Him that He would not forgive. (1 John 1:9, "If we confess our sins, he is faithful and just to forgive us our sins, and to cleanse us from ALL unrighteousness." and Titus 2:14, "Who gave Himself for us to redeem us from EVERY lawless deed, and to purify for Himself a people for His own possession, zealous for good deeds." (NASB))

You are blessed to have a Father who longs (deeply desires) to be gracious and compassionate towards you. (Isaiah 30:18, "Therefore the LORD longs to be gracious to you, And therefore He waits on high to have compassion on you. For the LORD is a God of justice; How blessed are all those who long for Him." (NASB) and Psalms 117:2, "For his merciful kindness is great toward us: and the truth of the LORD endureth for ever. Praise ye the LORD.")

Your heavenly Father loves to bring you joy by answering your prayers. (John 16:24, "Hitherto have ye asked nothing in my name: ask, and ye shall receive, that your joy may be full.")

You have a future awaiting you that is beyond what the human mind can comprehend. (1 Corinthians 2:9, "But as it is written, Eye hath not seen, nor ear heard, neither have entered into the heart of man, the things which God hath prepared for them that love him.")

EOS

blessing = blessings_text.split("\n").select{|b| !b.empty? }.sample

if OS.mac?
  system "say '#{blessing}'"
else
  puts
  puts blessing
  puts
end
